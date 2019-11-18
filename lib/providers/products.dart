import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nutrioshop/dummy_data.dart';
import 'package:nutrioshop/models/product.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addProduct(Product product) async {
    const url = 'https://nutrio-shop.firebaseio.com/products.json';
    final requestParams = {
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'isFavorite': product.isFavorite
    };

    try {
      return await http
      .post(url, body: json.encode(requestParams))
      .then((response) {
        final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl
        );

        _items.add(newProduct);
        notifyListeners();
      });
    } catch(error) {
      print(error);
      throw(error);
    }
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
