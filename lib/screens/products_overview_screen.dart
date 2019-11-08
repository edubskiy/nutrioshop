import 'package:flutter/material.dart';
import 'package:nutrioshop/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrio shop')
      ),
      body: ProductsGrid(),
    );
  }
}
