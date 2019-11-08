import 'package:flutter/material.dart';
import 'package:nutrioshop/models/product.dart';
import 'package:nutrioshop/providers/products_provider.dart';
import 'package:nutrioshop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<ProductsProvider>(context).items;
    
    return GridView.builder(
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
    );
  }
}
