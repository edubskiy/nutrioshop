import 'package:flutter/material.dart';
import 'package:nutrioshop/screens/orders_screen.dart';

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
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(120),
            alignment: Alignment.centerLeft,
            color: Colors.black,
            child: Text(
              'Nutrio Shop',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          SizedBox(height: 20,),
          buildListTile('Orders', Icons.shopping_cart, () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          }),
          // buildListTile('Filters', Icons.settings, () {
          //   Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          // }),
        ],
      ),
    );
  }
}
