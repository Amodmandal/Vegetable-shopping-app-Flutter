import 'package:flutter/cupertino.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _productsList;
  }
   List<ProductModel>get getOnSaleProducts{
    return _productsList.where((element) => element.isOnSale).toList();
   }
  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }
  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }
 List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }


  static final List<ProductModel> _productsList = [
    ProductModel(
      id: 'Carottes',
      title: 'Carottes',
      price: 30,
      salePrice: 20,
      imageUrl: 'https://i.ibb.co/TRbNL3c/Carottes.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: false,
    ),
    ProductModel(
      id: 'Cauliflower',
      title: 'Cauliflower',
      price: 45,
      salePrice: 40,
      imageUrl: 'https://i.ibb.co/xGWf2rH/Cauliflower.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Cucumber',
      title: 'Cucumber',
      price: 20,
      salePrice: 10,
      imageUrl: 'https://i.ibb.co/kDL5GKg/cucumbers.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Jalape',
      title: 'Jalape',
      price: 45,
      salePrice: 30,
      imageUrl: 'https://i.ibb.co/Dtk1YP8/Jalape-o.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Long yam',
      title: 'Long yam',
      price: 60,
      salePrice: 55,
      imageUrl: 'https://i.ibb.co/V3MbcST/Long-yam.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Onions',
      title: 'Onions',
      price: 70,
      salePrice: 60,
      imageUrl: 'https://i.ibb.co/GFvm1Zd/Onions.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Plantain-flower',
      title: 'Plantain-flower',
      price: 25,
      salePrice: 20,
      imageUrl: 'https://i.ibb.co/RBdq0PD/Plantain-flower.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Potato',
      title: 'Potato',
      price: 30,
      salePrice: 25,
      imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: false,
    ),
    ProductModel(
      id: 'Radish',
      title: 'Radish',
      price: 20,
      salePrice: 15,
      imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Red peppers',
      title: 'Red peppers',
      price: 30,
      salePrice: 25,
      imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
      productCategoryName: 'Vegetables',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Squash',
      title: 'Squash',
      price: 100,
      salePrice: 20,
      imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Tomatoes',
      title: 'Tomatoes',
      price: 30,
      salePrice: 25,
      imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
      productCategoryName: 'Vegetables',
      isOnSale: true,
      isPiece: false,
    ),
  ];

  
}
