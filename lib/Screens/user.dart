import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/Screens/Wishlist/wishlist_screen.dart';
import 'package:vegetable_app/Screens/auth/forgotpassword.dart';
import 'package:vegetable_app/Screens/loading_manger.dart';
import 'package:vegetable_app/Screens/orders/orders_screen.dart';
import 'package:vegetable_app/Screens/viewed_recently.dart/viewed_recently.dart';
import 'package:vegetable_app/consts/firebase_consts.dart';
import 'package:vegetable_app/services/global_methods.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../provider/dark_theme_provider.dart';
import 'auth/login.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _addressTextController =
      TextEditingController(text: '');
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('shipping-address');
        _addressTextController.text = userDoc.get('shipping-address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme
        ? Color.fromARGB(255, 252, 243, 243)
        : Color.fromARGB(255, 27, 24, 24);

    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Hi,  ',
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: _name == null ? "user" : _name,
                            style: TextStyle(
                                color: color,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('amod');
                              })
                      ]),
                ),
                TextWidget(
                  text: _email == null ? "Email" : _email!,
                  color: color,
                  textSize: 18,
                  //isTitle: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                _listTiles(
                    title: 'Address',
                    subtitle: address,
                    icon: IconlyLight.profile,
                    onpressed: () async {
                      await _showAddressDialog();
                    },
                    color: color),
               
                _listTiles(
                    title: 'WishList',
                    icon: IconlyLight.heart,
                    onpressed: () {
                      Navigator.pushNamed(context, WishlistScreen.routeName);
                    },
                    color: color),
                _listTiles(
                    title: 'Viewed',
                    icon: IconlyLight.show,
                    onpressed: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routeName);
                    },
                    color: color),
                _listTiles(
                  title: 'Forgot Password',
                  icon: IconlyLight.unlock,
                  color: color,
                  onpressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordScreen(),
                      ),
                    );
                  },
                ),
                SwitchListTile(
                  title: TextWidget(
                    text: themeState.getDarkTheme ? 'Dark Mode' : 'Light Mode',
                    color: color,
                    textSize: 22,
                    //isTitle: true,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme,
                ),
                SizedBox(
                  height: 10,
                ),
                _listTiles(
                    title: user == null ? 'Login' : 'Logout',
                    icon: user == null ? IconlyLight.login : IconlyLight.logout,
                    onpressed: () {
                      if (user == null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                        return;
                      }
                      GlobalMethods.warningDialog(
                          title: 'Sign out',
                          subtitle: 'Do you wanna sign out',
                          fct: () async {
                            await authInstance.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          context: context);
                    },
                    color: color)
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              onChanged: (value) {},
              controller: _addressTextController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Your Address', border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    String _uid = user!.uid;
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .update({
                        'shipping-address': _addressTextController.text,
                      });

                      Navigator.pop(context);
                      setState(() {
                        address = _addressTextController.text;
                      });
                    } catch (err) {
                      GlobalMethods.errorDialog(
                          subtitle: err.toString(), context: context);
                    }
                  },
                  child: Text('Update'))
            ],
          );
        });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onpressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 20,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: () {
        onpressed();
      },
    );
  }
}
