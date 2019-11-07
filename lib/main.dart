import 'package:flutter/material.dart';
import 'package:nutrioshop/screens/products_overview_screen.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrio shop',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        fontFamily: 'Lato'
      ),
      home: ProductsOverviewScreen()
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
