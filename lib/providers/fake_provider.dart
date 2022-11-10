import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/products_model.dart';

class productProvider with ChangeNotifier {
  List<ProductModel> newArchivesProductList = [];
  late ProductModel productmodel;

  fetchNewArchivesProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("products").get();
    value.docs.forEach((element) {
      productmodel = ProductModel(
        id: element.get('productid'),
        imageUrl: element.get('productimage'),
        isOnSale: element.get('isOnSale'),
        isPiece: element.get('isPiece'),
        price: element.get('productprice'),
        productCategoryName: element.get('productCategoryName'),
        salePrice: element.get('salePrice'),
        title: element.get('productname'),
        
          );
      newList.add(productmodel);
    });
    newArchivesProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getNewArchivesProductDatalist {
    return newArchivesProductList;
  }
}
