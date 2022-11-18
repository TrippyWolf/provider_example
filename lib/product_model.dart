import 'package:flutter/cupertino.dart';

class ProductModel {
  String productName;
  int price;
  bool isSelected;
  ProductModel(this.productName, this.price, this.isSelected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          productName == other.productName;
}

class ProductModelProvider extends ChangeNotifier {
  final List<ProductModel> _productModelList = [];
  void initialSetup() {
    _productModelList.add(ProductModel("T-Shirt", 399, false));
    _productModelList.add(ProductModel("Jeans", 999, false));
    _productModelList.add(ProductModel("Socks", 99, false));
    _productModelList.add(ProductModel("Shirt", 499, false));
  }

  void productClicked(index) {
    _productModelList.elementAt(index).isSelected =
        !_productModelList.elementAt(index).isSelected;
    notifyListeners();
  }

  List<ProductModel> get productModelList => _productModelList;
  List<ProductModel> get selectedProductList =>
      productModelList.where((element) => element.isSelected).toList();
}
