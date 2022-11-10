import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/providers/onsale_provider.dart';
import 'package:vegetable_app/widgets/back_widget.dart';
import 'package:vegetable_app/widgets/empty_products_weidgets.dart';
import 'package:vegetable_app/widgets/on_sale_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnsaleProvider onsaleProvider = Provider.of(context);
    onsaleProvider.fetchOnsaleProductData();
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final ProductProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = ProductProvider.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: Backwidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
            text: 'Product on sale', color: color, textSize: 24, isTitle: true),
      ),
      body: productsOnSale.isEmpty
          // ignore: dead_code
          ? EmptyProdWidget(
              text: 'No products belong to this category',
            )
          // ignore: dead_code
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: (size.width) / (size.height * 0.45),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsOnSale[index],
                  child: OnSaleWidget(),
                );
              }),
            ),
    );
  }
}
