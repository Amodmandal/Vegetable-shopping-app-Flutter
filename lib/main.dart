import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_app/Screens/Wishlist/wishlist_screen.dart';
import 'package:vegetable_app/Screens/auth/login.dart';
import 'package:vegetable_app/Screens/auth/register.dart';
import 'package:vegetable_app/Screens/btm_bar.dart';
import 'package:vegetable_app/Screens/orders/orders_screen.dart';
import 'package:vegetable_app/Screens/viewed_recently.dart/viewed_recently.dart';
import 'package:vegetable_app/fetch_screen.dart';
import 'package:vegetable_app/inner_screens/0nsale_screen.dart';
import 'package:vegetable_app/inner_screens/cat_screen.dart';
import 'package:vegetable_app/inner_screens/feeds_screen.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/providers/cart_provider.dart';
import 'package:vegetable_app/providers/onsale_provider.dart';
import 'package:vegetable_app/providers/products_provider.dart';
import 'Screens/auth/forgotpassword.dart';
import 'consts/theme_data.dart';
import 'inner_screens/product_details.dart';
import 'providers/viewed_pro_provider.dart';
import 'providers/wishlist_providers.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
 final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:_firebaseInitialization, 
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              )),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                  body: Center(
                child: Text('An error occured'),
              )),
            );
          }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(
              create: (_) => ProductsProvider(),
            ),
             ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishlistProvider(),
            ),
              ChangeNotifierProvider(
              create: (_) => ViewedProdProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OnsaleProvider(),
            ),
          ],
          child:
              Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Vegetable app',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: FetchScreen(),
              routes: {
                OnSaleScreen.routeName: (context) => OnSaleScreen(),
                FeedsScreen.routeName: (context) => FeedsScreen(),
                ProductDetails.routeName: (Context) => ProductDetails(),
                WishlistScreen.routeName: (context) => WishlistScreen(),
                OrdersScreen.routeName: (context) => OrdersScreen(),
                ViewedRecentlyScreen.routeName: (context) => ViewedRecentlyScreen(),
                RegisterScreen.routeName: (context) => RegisterScreen(),
                LoginScreen.routeName: (context) => LoginScreen(),
                ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
                CategoryScreen.routeName: (context) => CategoryScreen()
              },
            );
          }),
        );
      }
    );
  }
}
