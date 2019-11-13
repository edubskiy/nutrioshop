import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrioshop/providers/orders.dart' as OrderProvider;
import 'package:intl/';

class OrderItem extends StatelessWidget {
  final OrderProvider.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyyy hh:mm').format(order.dateTime)
          ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ],),
    );
  }
}
