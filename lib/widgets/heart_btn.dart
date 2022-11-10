import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../providers/wishlist_providers.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
      
        if (user == null) {
          GlobalMethods.errorDialog(
              subtitle: 'No user found, Please login first', context: context);
          return;
        }
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
          isInWishlist != null && isInWishlist == true
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: 22,
          color: isInWishlist != null && isInWishlist == true
              ? Colors.red
              : color),
    );
  }
}
