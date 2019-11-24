import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nutrioshop/models/http_exception.dart';
import 'package:nutrioshop/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  String token;
  String userId;

  Products(this.token, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts([ bool filterByUser = false ]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url = 'https://nutrio-shop.firebaseio.com/products.json?auth=$token&$filterString';
    try {
      final response = await http.get(url);
      final List<Product> loadedProduct = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      final favoritesURL = 'https://nutrio-shop.firebaseio.com/favorites/$userId.json?auth=$token';
      final favoritesResponse = await http.get(favoritesURL);
      final favoriteData = json.decode(favoritesResponse.body);

      extractedData.forEach((productId, product) {
        loadedProduct.add(Product(
          id: productId,
          title: product['title'],
          price: product['price'],
          description: product['description'],
          isFavorite: favoriteData == null ? false : favoriteData[productId] ?? false,
          imageUrl: product['imageUrl']
        ));
      });

      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw(error);
    }
  }

  List<Product> getFavoritesOnly() {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://nutrio-shop.firebaseio.com/products.json?auth=$token';
    final requestParams = {
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'creatorId': userId
    };

    try {
      final response =  await http.post(url, body: json.encode(requestParams));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl
      );

      _items.add(newProduct);
      notifyListeners();
    } catch(error) {
      print(error);
      throw(error);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = 'https://nutrio-shop.firebaseio.com/products/$id.json?auth=$token';
    final requestParams = {
      'title': newProduct.title,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
      'price': newProduct.price,
      'isFavorite': newProduct.isFavorite
    };

    final productIndex = _items.indexWhere((product) => product.id == id);

    if (productIndex >= 0) {
      try {
        await http.patch(url, body: json.encode(requestParams));
      } catch(error) {
        throw(error);
      }
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://nutrio-shop.firebaseio.com/products/$id.json?auth=$token';
    final productIndex = _items.indexWhere((product) => product.id == id);
    Product cachedProduct = _items[productIndex];
    
    _items.removeAt(productIndex);
    notifyListeners();
    
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(productIndex, cachedProduct);
      notifyListeners();
      throw HTTPException("Items was not deleted");
    }
    cachedProduct = null;  
  }
}
