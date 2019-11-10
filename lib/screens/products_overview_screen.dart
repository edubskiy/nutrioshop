import 'package:flutter/material.dart';
import 'package:nutrioshop/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrio shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) => {
              if (selectedValue == FilterOptions.Favorites) {
                setState(() => _showFavoritesOnly = true)
              } else {
                setState(() => _showFavoritesOnly = true)
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
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
