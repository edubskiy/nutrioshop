import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/orders.dart' show Orders;
import 'package:nutrioshop/widgets/app_drawer.dart';
import 'package:nutrioshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator());  
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do handle error here
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (cxt, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (_, i) => OrderItem(orderData.orders[i])
                ),
              );
            }
          }
        },  
      ),
    );
  }
}
