import 'package:flutter/material.dart';
import 'package:nutrioshop/models/product.dart';
import 'package:nutrioshop/widgets/product_item.dart';

import '../dumm_data.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> products = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrio shop')
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(
          id: products[i].id,
          title: products[i].title,
          imageUrl: products[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
      ),
    );
  }
}
