import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../provider/dark_theme_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {Key? key,
      required this.catText,
      required this.imagPath,
      required this.passcolor})
      : super(key: key);
  final String catText, imagPath;
  final Color passcolor;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    Size size = MediaQuery.of(context).size;
    double _screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: passcolor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: passcolor.withOpacity(0.7),
              width: 2,
            )),
        child: Column(
          children: [
            Container(
              height: _screenwidth * 0.3,
              width: _screenwidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagPath), fit: BoxFit.fill)),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
