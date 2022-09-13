import 'package:flutter/material.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.saleprice,
      required this.price,
      required this.textPrice,
      required this.isOnSale})
      : super(key: key);
  final double saleprice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnSale ? saleprice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: '\Rs${(userPrice * int.parse(textPrice))}',
            color: Colors.green,
            textSize: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnSale ? true : false,
            child: Text(
              '\Rs${(price * int.parse(textPrice))}',
              style: TextStyle(
                  fontSize: 15,
                  color: color,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
