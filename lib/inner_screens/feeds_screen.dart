import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/models/products_model.dart';
import 'package:vegetable_app/providers/products_provider.dart';
import 'package:vegetable_app/widgets/back_widget.dart';

import '../consts/contss.dart';
import '../services/utils.dart';
import '../widgets/empty_products_weidgets.dart';
import '../widgets/feeds_items.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  FeedsScreen({Key? key}) : super(key: key);
  static const routeName = "/FeedsScreen";
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTexTFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTexTFocusNode.dispose();
    super.dispose();
  }

  List<ProductModel> listProdcutSearch = [];
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    final ProductProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = ProductProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: Backwidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
            text: ' All products', color: color, textSize: 24, isTitle: true),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTexTFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      listProdcutSearch = ProductProvider.searchQuery(value);
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      hintText: "What's is your mind",
                      prefixIcon: Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTexTFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTexTFocusNode.hasFocus
                              ? Colors.red
                              : color,
                        ),
                      )),
                ),
              ),
            ),
            _searchTextController!.text.isNotEmpty && listProdcutSearch.isEmpty
                ? const EmptyProdWidget(
                    text: 'No products found, please try another keyword')
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.59),
                    children: List.generate(
                        _searchTextController!.text.isNotEmpty
                            ? listProdcutSearch.length
                            : allProducts.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController!.text.isNotEmpty
                            ? listProdcutSearch[index]
                            : allProducts[index],
                        child: FeedsWidget(),
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
