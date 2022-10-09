import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:vegetable_app/widgets/on_sale_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEmpty =true;
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
            text: 'Product on sale', color: color, textSize: 24, isTitle: true),
      ),
      body: _isEmpty
          // ignore: dead_code
          ? Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/box.png'),
                      ),
                      Text(
                        'No product on sale yet!,\nStay tuned',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: color,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )))
          // ignore: dead_code
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio:( size.width) / (size.height * 0.45),
              children: List.generate(10, (index) {
                return OnSaleWidget();
              }),
            ),
    );
  }
}
