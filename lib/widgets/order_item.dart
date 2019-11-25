import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrioshop/providers/orders.dart' as OrderProvider;

class OrderItem extends StatefulWidget {
  final OrderProvider.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded 
        ? min(widget.order.products.length * 20 + 110.0, 200) 
        : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = ! _expanded),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4
            ),
            height: _expanded 
              ? min(widget.order.products.length * 20 + 10.0, 100)
              : 0,
            child: ListView(
              children: widget.order.products.map((product) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    product.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                  ),
                  Text(
                    "${product.quantity}x \$${product.price}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      )
                  ),
                ],)).toList(),
            ),
          )
        ],),
      ),
    );
  }
}
