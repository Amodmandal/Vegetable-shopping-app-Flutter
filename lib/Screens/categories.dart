import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/widgets/categories_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../provider/dark_theme_provider.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];
  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/cat/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/cat/veg.png',
      'catText': 'Vegetables',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: TextWidget(
            text: 'Categories',
            color: color,
            textSize: 22,
            isTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            childAspectRatio: 230 / 250,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(2, (index) {
              return CategoryWidget(
                catText: catInfo[index]['catText'],
                imagPath: catInfo[index]['imgPath'],
                passcolor: gridColors[index],
              );
            }),
          ),
        ));
  }
}
