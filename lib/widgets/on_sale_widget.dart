import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/inner_screens/product_details.dart';
import 'package:vegetable_app/services/utils.dart';
import 'package:vegetable_app/widgets/heart_btn.dart';
import 'package:vegetable_app/widgets/price_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../consts/firebase_consts.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_providers.dart';
import '../services/global_methods.dart';

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
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        //color: Theme.of(context).cardColor.withOpacity(0.1),
        //borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
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
                        imageUrl: productModel.imageUrl,
                        //width: size.width * 0.22,
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          TextWidget(
                            text: productModel.isPiece ? '1piece' : '1KG',
                            color: color,
                            textSize: 18,
                            isTitle: true,
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _isInCart
                                    ? null
                                    : () {
                                        final User? user =
                                            authInstance.currentUser;

                                        if (user == null) {
                                          GlobalMethods.errorDialog(
                                              subtitle:
                                                  'No user found, Please login first',
                                              context: context);
                                          return;
                                        }
                                        cartProvider.addProductsToCart(
                                            productId: productModel.id,
                                            quantity: 1);
                                      },
                                child: Icon(
                                    _isInCart
                                        ? IconlyBold.bag2
                                        : IconlyLight.bag2,
                                    size: 22,
                                    color: _isInCart ? Colors.green : color),
                              ),
                              HeartBTN(
                                productId: productModel.id,
                                isInWishlist: _isInWishlist,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  PriceWidget(
                    saleprice: productModel.salePrice,
                    price: productModel.price,
                    textPrice: '1',
                    isOnSale: true,
                  ),
                  SizedBox(height: 5),
                  TextWidget(
                      text: productModel.title,
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
