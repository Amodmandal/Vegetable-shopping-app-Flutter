import 'package:flutter/material.dart';
import 'package:vegetable_app/inner_screens/feeds_screen.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagPath,
      required this.title,
      required this.subtitle,
      required this.buttontext})
      : super(key: key);
  final String imagPath, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    final themeState = Utils(context).getTheme;
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                imagPath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              SizedBox(height: 10),
              Text(
                'Whoops',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(text: title, color: Colors.cyan, textSize: 20),
              SizedBox(height: 20),
              TextWidget(text: subtitle, color: Colors.cyan, textSize: 20),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    primary: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, FeedsScreen.routeName);
                  },
                  child: TextWidget(
                    text: buttontext,
                    color: themeState
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
                    textSize: 20,
                    isTitle: true,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
