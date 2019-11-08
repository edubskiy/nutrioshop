import 'package:flutter/material.dart';
import 'package:nutrioshop/models/product.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final Product product = Provider.of<Products>(
      context,
      listen: false
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text(productId),
      ),
    );
  }
}
