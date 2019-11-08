import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/screens/product_details_screen.dart';
import 'package:nutrioshop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (BuildContext _) => Products(),
      child: MaterialApp(
        title: 'Nutrio shop',
        // theme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.tealAccent,
          fontFamily: 'Lato'
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen()
        },
      ),
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
