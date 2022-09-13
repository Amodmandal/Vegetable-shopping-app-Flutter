import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Color.fromARGB(255, 209, 195, 195) : Color.fromARGB(255, 40, 29, 29);
  Size get getscreensize => MediaQuery.of(context).size;
}
