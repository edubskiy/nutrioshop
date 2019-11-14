import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/widgets/app_drawer.dart';
import 'package:nutrioshop/widgets/manage/manage_products_item.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              ManageProducstItem(
                title: products.items[i].title,
                imageUrl: products.items[i].imageUrl,
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
