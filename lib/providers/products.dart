import 'package:flutter/foundation.dart';
import 'package:nutrioshop/dummy_data.dart';
import 'package:nutrioshop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  bool _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      print('return only favorites');
      return _items.where((item) => item.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addProduct(product) {
    _items.add(product);
    notifyListeners();
  }
}
