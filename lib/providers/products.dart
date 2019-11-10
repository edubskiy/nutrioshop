import 'package:flutter/foundation.dart';
import 'package:nutrioshop/dummy_data.dart';
import 'package:nutrioshop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> getFavoritesOnly() {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addProduct(product) {
    _items.add(product);
    notifyListeners();
  }
}
