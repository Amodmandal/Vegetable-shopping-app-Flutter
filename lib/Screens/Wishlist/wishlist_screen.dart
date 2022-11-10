import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/Screens/Wishlist/wishlist_widget.dart';

import 'package:vegetable_app/providers/wishlist_providers.dart';
import 'package:vegetable_app/widgets/back_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/empty_screen.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({Key? key}) : super(key: key);
  static const routeName = "/WishlistScreen";

  @override
  State<WishlistScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? EmptyScreen(
            imagPath: 'assets/images/wishlist.png',
            title: ' Your wishlist is empty',
            subtitle: 'Explore more and shortlist some items',
            buttontext: 'Add a wish')
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Backwidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                  text: 'Wishlist (${wishlistItemsList.length})',
                  color: color,
                  textSize: 22,
                  isTitle: true),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your wishlist ?',
                          subtitle: 'Are you sure?',
                          fct: () {
                            wishlistProvider.clearWishlist();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ))
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ),
          );
  }
}
