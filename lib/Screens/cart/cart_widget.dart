import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/inner_screens/product_details.dart';
import 'package:vegetable_app/models/cart_model.dart';
import 'package:vegetable_app/models/products_model.dart';
import 'package:vegetable_app/providers/products_provider.dart';
import 'package:vegetable_app/widgets/heart_btn.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../../providers/cart_provider.dart';
import '../../providers/wishlist_providers.dart';
import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productsProvider.findProdById(cartModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: cartModel.productId);
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 0.22,
                          width: size.width * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FancyShimmerImage(
                            imageUrl: getCurrProduct.imageUrl,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: getCurrProduct.title,
                                color: color,
                                textSize: 20,
                                isTitle: true),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: Row(
                                children: [
                                  _quantityController(
                                      fct: () {
                                        if (_quantityTextController.text ==
                                            '1') {
                                          return;
                                        } else {
                                          cartProvider.reduceQuantityByOne(
                                              cartModel.productId);
                                          setState(() {
                                            _quantityTextController
                                                .text = (int.parse(
                                                        _quantityTextController
                                                            .text) -
                                                    1)
                                                .toString();
                                          });
                                        }
                                      },
                                      color: Colors.red,
                                      icon: CupertinoIcons.minus),
                                  Flexible(
                                    child: TextField(
                                      controller: _quantityTextController,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.]'))
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          if (value.isEmpty) {
                                            _quantityTextController.text = '1';
                                          } else {
                                            return;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  _quantityController(
                                      fct: () {
                                        cartProvider.increaseQuantityByOne(
                                            cartModel.productId);
                                        setState(() {
                                          cartProvider.increaseQuantityByOne(
                                              cartModel.productId);
                                          _quantityTextController.text =
                                              (int.parse(_quantityTextController
                                                          .text) +
                                                      1)
                                                  .toString();
                                        });
                                      },
                                      color: Colors.green,
                                      icon: CupertinoIcons.plus),
                                ],
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  cartProvider
                                      .removeOneItem(cartModel.productId);
                                },
                                child: Icon(
                                  CupertinoIcons.cart_badge_minus,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              HeartBTN(
                                productId: getCurrProduct.id,
                                isInWishlist: _isInWishlist,
                              ),
                              TextWidget(
                                text: 'RS ${totalPrice.toStringAsFixed(2)}',
                                color: color,
                                textSize: 18,
                                maxLines: 1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

Widget _quantityController(
    {required Function fct, required IconData icon, required Color color}) {
  return Flexible(
    flex: 2,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {fct();},
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
