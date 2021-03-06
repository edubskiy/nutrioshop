import 'package:flutter/material.dart';
import 'package:nutrioshop/manage/screens/manage_edit_product_screen.dart';
import 'package:nutrioshop/manage/widgets/manage_products_item.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:nutrioshop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage';

  Future<void> _refreshProducts(BuildContext context) async {
    return Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .pushNamed(ManageEditProductScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<Products>(
            builder: (ctx, products, _) => Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (_, i) => Column(
                children: <Widget>[
                  ManageProducstItem(
                    id: products.items[i].id,
                    title: products.items[i].title,
                    imageUrl: products.items[i].imageUrl
                  ),
                  Divider()
                ],
              ),
            ),
          ),
          ) 
        ),
      ),
    );
  }
}
