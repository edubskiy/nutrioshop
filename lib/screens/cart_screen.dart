import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/cart.dart' show Cart;
import 'package:nutrioshop/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:nutrioshop/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Your cart'),),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}', // cartProvider.totalAmount.toString()
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'), 
                    onPressed: () {
                      order.addOrder(
                        cart.items.values.toList(), 
                        cart.totalAmount
                      );
                      cart.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
              ],),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) {
                final ci = cart.items.values.toList()[i];
                  return CartItem(
                    id: ci.id,
                    productId: cart.items.keys.toList()[i],
                    price: ci.price,
                    title: ci.title,
                    quantity: ci.quantity,
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}
