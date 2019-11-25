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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 30,),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 800,)
              ]
            ),
          ),
        ],
      ),
    );
  }
}
