import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/models/wishlist_model.dart';
import 'package:vegetable_app/widgets/heart_btn.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../../inner_screens/product_details.dart';
import '../../models/cart_model.dart';
import '../../providers/products_provider.dart';
import '../../providers/wishlist_providers.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct =
        productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
           Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: wishlistModel.productId);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.7),
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                width: size.width * 0.2,
                height: size.width * 0.25,
                child: FancyShimmerImage(
                  imageUrl:
                     getCurrProduct.imageUrl,
                  boxFit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.bag2,
                            color: color,
                          ),
                        ),
                         HeartBTN(
                         productId: getCurrProduct.id,
                        isInWishlist: _isInWishlist,
                          )
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextWidget(
                      text: getCurrProduct.title,
                      color: color,
                      textSize: 20,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextWidget(
                    text: '\RS ${usedPrice.toStringAsFixed(2)}',
                    color: color,
                    textSize: 18.0,
                    maxLines: 1,
                    isTitle: true,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
