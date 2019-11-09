import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrio shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) => {
              if (selectedValue == FilterOptions.Favorites) {
                productsProvider.showFavoritesOnly()
              } else {
                productsProvider.showAll()
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites only'),
                value: FilterOptions.Favorites
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
