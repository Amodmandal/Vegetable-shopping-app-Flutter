import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/inner_screens/product_details.dart';
import 'package:vegetable_app/widgets/heart_btn.dart';
import 'package:vegetable_app/widgets/price_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../consts/firebase_consts.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_providers.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class FeedsWidget extends StatefulWidget {
  FeedsWidget({Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
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
    //final theme = Utils(context).getTheme;
    Size size = Utils(context).getscreensize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                //width: size.width * 0.22,
                height: size.width * 0.22,
                width: size.width * 0.22,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                          text: productModel.title,
                          color: color,
                          maxLines: 1,
                          textSize: 18,
                          isTitle: true),
                    ),
                    Flexible(
                        flex: 1,
                        child: HeartBTN(
                          productId: productModel.id,
                          isInWishlist: _isInWishlist,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: PriceWidget(
                        saleprice: productModel.salePrice,
                        price: productModel.price,
                        textPrice: _quantityTextController.text,
                        isOnSale: productModel.isOnSale,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                                text: productModel.isPiece ? 'Piece' : 'kg',
                                color: color,
                                textSize: 16,
                                isTitle: true),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              flex: 2,
                              child: TextFormField(
                                controller: _quantityTextController,
                                key: const ValueKey('10'),
                                style: TextStyle(color: color, fontSize: 18),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                enabled: true,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.]'))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isInCart
                      ? null
                      : () {
                          final User? user = authInstance.currentUser;

                          if (user == null) {
                            GlobalMethods.errorDialog(
                                subtitle: 'No user found, Please login first',
                                context: context);
                            return;
                          }
                          cartProvider.addProductsToCart(
                              productId: productModel.id,
                              quantity:
                                  int.parse(_quantityTextController.text));
                        },
                  child: TextWidget(
                    text: _isInCart ? 'In cart' : 'Add to cart',
                    maxLines: 2,
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
