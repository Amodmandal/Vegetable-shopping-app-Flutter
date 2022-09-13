import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../provider/dark_theme_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Color.fromARGB(255, 252, 243, 243) : Color.fromARGB(255, 27, 24, 24);

    return Scaffold(
    
      body: Center(
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
                          text: 'Amod Mandal',
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
                text: 'mandala573@gmail.com',
                color: color,
                textSize: 18,
                //isTitle: true,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              _listTiles(
                  title: 'Address',
                  subtitle: 'Lokanthali',
                  icon: IconlyLight.profile,
                  onpressed: () async {
                    await _showAddressDialog();
                  },
                  color: color),
              _listTiles(
                  title: 'Order',
                  icon: IconlyLight.bag,
                  onpressed: () {},
                  color: color),
              _listTiles(
                  title: 'WishList',
                  icon: IconlyLight.heart,
                  onpressed: () {},
                  color: color),
              _listTiles(
                  title: 'Viewed',
                  icon: IconlyLight.show,
                  onpressed: () {},
                  color: color),
              _listTiles(
                title: 'Forgot Password',
                icon: IconlyLight.unlock,
                color: color,
                onpressed: () {},
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
                  title: 'Logout',
                  icon: IconlyLight.logout,
                  onpressed: () {
                    _showLogoutDialog();
                  },
                  color: color)
            ],
          ),
        )),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Sign out')
              ],
            ),
            content: Text('Do you wanna sign out?'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Color.fromARGB(255, 233, 71, 12),
                  text: 'Ok',
                  textSize: 18,
                ),
              )
            ],
          );
        });
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
            actions: [TextButton(onPressed: () {}, child: Text('Update'))],
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
