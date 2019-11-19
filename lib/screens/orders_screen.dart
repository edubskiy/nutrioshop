import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/orders.dart' show Orders;
import 'package:nutrioshop/widgets/app_drawer.dart';
import 'package:nutrioshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      await Provider.of<Orders>(context, listen: false).fetchAndSetProducts();
      setState(() => _isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: order.orders.length,
          itemBuilder: (_, i) => OrderItem(order.orders[i]),
        ),
    );
  }
}
