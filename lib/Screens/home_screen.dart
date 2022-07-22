import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Center(
          child: SwitchListTile(
        title: TextWidget(
            text: themeState.getDarkTheme ? 'Dark mode' : 'Light Mode',
            color: themeState.getDarkTheme? Colors.white:Colors.black,
            textSize: 18),
        secondary: Icon(themeState.getDarkTheme
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
        onChanged: (bool value) {
          setState(() {
            themeState.setDarkTheme = value;
          });
        },
        value: themeState.getDarkTheme,
      )),
    );
  }
}
