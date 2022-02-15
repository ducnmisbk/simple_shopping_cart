import 'package:flutter/cupertino.dart';
import 'package:simple_shopping_cart/models/Product.dart';

class CartModel with ChangeNotifier {
  late List<Product> _items = [];

  List<Product> get items => _items;

  bool isProductAdded(int id) {
    var contain = _items.where((element) => element.id == id);
    return contain.isNotEmpty;
  }

  double get totalPrice =>
      _items.fold(0, (total, current) => total + current.price);

  bool get isEmpty => _items.isEmpty;

  Future<bool> add(Product? p) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (p != null && !isProductAdded(p.id)) {
        _items.add(p);
        notifyListeners();
        return true;
      } else {
        print('item existed');
        return false;
      }
    });
  }

  void remove(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<bool> buy() async {
    return Future.delayed(const Duration(seconds: 5), () {
      _items = [];
      notifyListeners();
      return true;
    });
  }
}
