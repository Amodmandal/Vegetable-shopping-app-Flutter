import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/Screens/cart/cart_widget.dart';

import 'package:vegetable_app/widgets/empty_screen.dart';
import 'package:vegetable_app/services/global_methods.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../../PaymentMethod/PaymentMethod.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
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
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemsList.isEmpty
        ? EmptyScreen(
            imagPath: 'assets/images/cart.png',
            title: ' Your cart is empty',
            subtitle: 'Add something and make me happy :)',
            buttontext: 'Shop now')
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                  text: 'Cart(${cartItemsList.length})',
                  color: color,
                  textSize: 22,
                  isTitle: true),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your cart ?',
                          subtitle: 'Are you sure?',
                          fct: () {
                            cartProvider.clearCart();
                          },
                          context: context);
                    },
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
                      itemCount: cartItemsList.length,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                            value: cartItemsList[index],
                            child: CartWidget(
                              q: cartItemsList[index].quantity,
                            ));
                      }),
                ),
              ],
            ));
  }

  Widget _checkout() {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    double total = 0.0;
    cartProvider.getCartItems.forEach(
      (key, value) {
        final getCurrProduct = productProvider.findProdById(value.productId);
        total += (getCurrProduct.isOnSale
                ? getCurrProduct.salePrice
                : getCurrProduct.price) *
            value.quantity;
      },
    );
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayementPage(),
                      ));
                },
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
                  text: 'Total:\Rs ${total.toStringAsFixed(2)}',
                  color: color,
                  textSize: 18,
                  isTitle: true),
            )
          ],
        ),
      ),
    );
  }
}
