import 'package:flutter/material.dart';
import 'package:nutrioshop/manage/screens/manage_edit_product_screen.dart';
import 'package:nutrioshop/providers/auth.dart';
import 'package:nutrioshop/providers/cart.dart';
import 'package:nutrioshop/providers/orders.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/screens/auth_screen.dart';
import 'package:nutrioshop/screens/cart_screen.dart';
import 'package:nutrioshop/screens/orders_screen.dart';
import 'package:nutrioshop/screens/product_details_screen.dart';
import 'package:nutrioshop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import 'manage/screens/manage_products_screen.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts.items
          ),
          initialBuilder: (_) => Products('', '',[]),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders.orders
          ),
          initialBuilder: (_) => Orders('', '', []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Nutrio shop',
          // theme: ThemeData.dark(),
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.tealAccent,
            fontFamily: 'Lato'
          ),
          home: auth.isAuth 
            ? ProductsOverviewScreen() 
            : AuthScreen(),
          routes: {
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
            ManageEditProductScreen.routeName: (ctx) => ManageEditProductScreen(),
          },
        )
      ) 
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrio')
      ),
      body: Center(
        child: Text('Our Nutrio shop'),
      ),

    );
  }
}
