import 'package:flutter/foundation.dart';
import 'package:nutrioshop/dummy_data.dart';
import 'package:nutrioshop/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  void addProduct(product) {
    _items.add(product);
    notifyListeners();
  }
}
