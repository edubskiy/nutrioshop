import 'package:flutter/material.dart';
import 'package:nutrioshop/manage/screens/manage_products_screen.dart';
import 'package:nutrioshop/providers/auth.dart';
import 'package:nutrioshop/screens/orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(icon, size: 26,),
      title: Text(
        title,
        style: TextStyle(
          // fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Nutrio Shop'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Catalog'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed(ManageProductsScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
