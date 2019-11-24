import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price, 
    @required this.imageUrl,
    this.isFavorite = false
  });

  void _setFavoriteStatus(value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async { // optimistic update
    final url = 'https://nutrio-shop.firebaseio.com/favorites/$userId/$id.json?auth=$token';
    final cachedFavoriteStatus = isFavorite;
    
    isFavorite = ! isFavorite;
    notifyListeners();

    try {
      final response = await http.put(url, body: json.encode(isFavorite));

      // for patch and delete requests we don't reach catch(error) method,
      // instead we have to manually read and react to bad status here
      if (response.statusCode >= 400) {
        _setFavoriteStatus(cachedFavoriteStatus);
      }

    } catch (e) {
      _setFavoriteStatus(cachedFavoriteStatus);
    }
  }
}
