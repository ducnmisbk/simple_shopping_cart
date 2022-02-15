import 'package:flutter/cupertino.dart';
import 'package:simple_shopping_cart/models/Product.dart';
import 'package:simple_shopping_cart/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> productList = [];
  bool isLoading = false;
  final ProductService _productService = ProductService();

  ProductProvider() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    productList = await _productService.getProducts();
    isLoading = false;
    notifyListeners();
  }
}