import 'package:flutter/material.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

class cashondelivery extends StatefulWidget {
  cashondelivery({Key? key}) : super(key: key);

  @override
  State<cashondelivery> createState() => _cashondeliveryState();
}

class _cashondeliveryState extends State<cashondelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Cash On Delivery",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextWidget(
                text: 'Order Successful', color: Colors.black, textSize: 20),
          ),
          Center(
            child: Image.asset(
              'assets/esewa/successful.png',
              height: 24,
              width: 54,
            ),
          )
        ],
      ),
    );
  }
}
