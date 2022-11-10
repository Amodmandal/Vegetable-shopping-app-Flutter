import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetable_app/models/onsale_model.dart';

class OnsaleProvider with ChangeNotifier {
  List<OnsaleModel> newArchivesProductList = [];
  late OnsaleModel onsalemodel;

  fetchOnsaleProductData() async {
    List<OnsaleModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("NewArchives").get();
    value.docs.forEach((element) {
      onsalemodel = OnsaleModel(
        price: element.get('productprice'),
        salePrice: element.get('onsaleprice'),
          productname: element.get('productname'),
          productimage: element.get('productimage'),
          productid: element.get('productid'));
      newList.add(onsalemodel);
    });
    newArchivesProductList = newList;
    notifyListeners();
  }

  List<OnsaleModel> get getOnsaleProductDatalist {
    return newArchivesProductList;
  }
}