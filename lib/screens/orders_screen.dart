import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/orders.dart' show Orders;
import 'package:nutrioshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemCount: order.orders.length,
        itemBuilder: (_, i) => OrderItem(order.orders[i]),
      ),
    );
  }
}
