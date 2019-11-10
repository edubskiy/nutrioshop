import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavoritesOnly;

  ProductsGrid(this._showFavoritesOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final products = _showFavoritesOnly 
      ? productsProvider.getFavoritesOnly()
      : productsProvider.items;
    
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
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
