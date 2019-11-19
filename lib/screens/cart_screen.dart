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
                      '\$${cart.totalAmount.toStringAsFixed(2)}', // cartProvider.totalAmount.toString()
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({ @required this.cart });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context, listen: false);
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'), 
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });
        await orderProvider.addOrder(
          widget.cart.items.values.toList(), 
          widget.cart.totalAmount
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
