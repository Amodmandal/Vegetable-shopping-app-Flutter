import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/PaymentMethod/esewa_int.dart';
import 'package:vegetable_app/paymentmethod/cash_on%20delivery.dart';
import 'package:vegetable_app/paymentmethod/khalti_main.dart';


import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

class PayementPage extends StatefulWidget {
  const PayementPage({Key? key}) : super(key: key);

  @override
  State<PayementPage> createState() => _PayementPageState();
}

class _PayementPageState extends State<PayementPage> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      bottomNavigationBar: ListTile(
        tileColor: Colors.white,
        title: const Text('Total Amount'),
        trailing:
            Text('Rs.${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Select Payement Method",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Recommended method(s)',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
           InkWell(
            onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KhaltiPaymentApp(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.credit_card),
              title: Text(' Khalti Payment'),
              trailing: Text('>'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Payement method(s)',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
         
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EsewaIntegration(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.wallet),
              title: Text('eSewa Mobile Wallet'),
              trailing: Text('>'),
            ),
          ),
          
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cashondelivery(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.money),
              title: Text('Cash On Delivery'),
              trailing: Text('>'),
            ),
          ),
        ]),
      ),
    );
  }
}
