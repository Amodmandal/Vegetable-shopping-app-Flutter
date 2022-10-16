import 'package:flutter/material.dart';
import 'package:vegetable_app/widgets/back_widget.dart';
import 'package:vegetable_app/widgets/empty_screen.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    bool _isEmpty = true;
    return _isEmpty == true
        ? EmptyScreen(
            imagPath: 'assets/images/cart.png',
            title: ' Your didnt place any order yet',
            subtitle: 'order something and make me happy :)',
            buttontext: 'Shop now')
        : Scaffold(
            appBar: AppBar(
              leading: const Backwidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Yours orders(2)',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ));
  }
}
