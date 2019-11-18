import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/cart.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/screens/cart_screen.dart';
import 'package:nutrioshop/widgets/app_drawer.dart';
import 'package:nutrioshop/widgets/badge.dart';
import 'package:nutrioshop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

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
  bool _isInited = false;

  @override
  void didChangeDependencies() {
    if ( ! _isInited) {
      Provider.of<Products>(context).fetchAndSetProducts();
    }
    _isInited = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Nutrio shop'),
        
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) => {
              if (selectedValue == FilterOptions.Favorites) {
                setState(() => _showFavoritesOnly = true)
              } else {
                setState(() => _showFavoritesOnly = false)
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
          ),
          Consumer<Cart>(
            builder: (_, cart, anyCartChild) => Badge(
              child: anyCartChild,
              value: cart.itemCount.toString(),
              color: Colors.black,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart), 
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
            ),),
        ],
      ),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
