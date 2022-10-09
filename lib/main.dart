import 'package:flutter/material.dart';
import 'package:vegetable_app/Screens/btm_bar.dart';
import 'package:vegetable_app/inner_screens/0nsale_screen.dart';
import 'package:vegetable_app/inner_screens/feeds_screen.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'inner_screens/product_details.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vegetable app',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: BottomBarScreen(),
          routes: {
            OnSaleScreen.routeName: (context) => OnSaleScreen(),
            FeedsScreen.routeName: (context) => FeedsScreen(),
           // ProductDetails.routeName: (Context) => ProductDetails()
          },
        );
      }),
    );
  }
}
