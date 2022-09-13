import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:vegetable_app/Screens/cart/cart_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../../services/utils.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return Scaffold(
    
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
              text: 'Cart(2)', color: color, textSize: 22, isTitle: true),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ))
          ],
        ),
        body: Column(
          children: [
            _checkout(),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    return CartWidget();
                  }),
            ),
          ],
        ));
  }

  Widget _checkout() {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      text: 'Order Now', color: Colors.white, textSize: 20),
                ),
              ),
            ),
            Spacer(),
            FittedBox(
              child: TextWidget(
                  text: 'Total:\Rs20', color: color, textSize: 18, isTitle: true),
            )
          ],
        ),
      ),
    );
  }
}
