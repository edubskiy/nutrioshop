import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

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
                  // SizedBox(width: 10,),
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalAmount}', // cartProvider.totalAmount.toString()
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'), 
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  )
              ],),
            ),
          )
        ],
      ),
    );
  }
}
