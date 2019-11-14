import 'package:flutter/material.dart';

class ManageEditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  @override
  _ManageEditProductScreenState createState() =>
      _ManageEditProductScreenState();
}

class _ManageEditProductScreenState extends State<ManageEditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
