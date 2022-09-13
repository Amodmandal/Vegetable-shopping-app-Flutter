import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:vegetable_app/services/utils.dart';
import 'package:vegetable_app/widgets/heart_btn.dart';
import 'package:vegetable_app/widgets/price_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _nameState();
}

class _nameState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    //final theme = Utils(context).getTheme;
    Size size = Utils(context).getscreensize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        //color: Theme.of(context).cardColor.withOpacity(0.1),
        //borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl:
                            'https://www.pngmart.com/files/8/Cauliflower-PNG-Image-HD.png',
                        //width: size.width * 0.22,
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          TextWidget(
                            text: '1KG',
                            color: color,
                            textSize: 18,
                            isTitle: true,
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(IconlyLight.bag2,
                                    size: 22, color: color),
                              ),
                              HeartBTN()
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  PriceWidget(
                    saleprice: 20,
                    price: 30,
                    textPrice: '1',
                    isOnSale: true,
                  ),
                  SizedBox(height: 5),
                  TextWidget(
                      text: 'Product title',
                      color: color,
                      textSize: 16,
                      isTitle: true),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
