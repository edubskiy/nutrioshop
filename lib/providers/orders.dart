import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nutrioshop/models/http_exception.dart';
import 'package:nutrioshop/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSetProducts() async {
    const url = 'https://nutrio-shop.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      extractedData.forEach((orderId, order) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: order['amount'],
          dateTime: DateTime.parse(order['dateTime']),
          products: (order['products'] as List<dynamic>)
            .map((item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title']
            ))
            .toList()
        ));
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://nutrio-shop.firebaseio.com/orders.json';
    DateTime currentTime = DateTime.now();
    final requestParams = {
      'amount': total,
      'dateTime': currentTime.toIso8601String(),
      'products': cartProducts.map((cardProduct) => {
        'id': cardProduct.id,
        'title': cardProduct.title,
        'quantity': cardProduct.quantity,
        'price': cardProduct.price
      }).toList()
    };

    try {
      final response =  await http.post(url, body: json.encode(requestParams));

      _orders.insert(0, OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: currentTime,
        products: cartProducts
      ));

      notifyListeners();

    } catch (e) {
      throw HTTPException('Something went wrong');
    }
  }
}
