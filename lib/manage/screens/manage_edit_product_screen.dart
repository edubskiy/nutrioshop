import 'package:flutter/material.dart';
import 'package:nutrioshop/providers/products.dart';
import 'package:provider/provider.dart';

/// To make it easier to set product product 
/// properties make them mutable for form submit process
class MutableProduct {
  String title;
  String description;
  double price;
  String imageUrl;

  MutableProduct({
    @required this.title,
    @required this.description,
    @required this.price, 
    @required this.imageUrl,
  });
}

class ManageEditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  @override
  _ManageEditProductScreenState createState() =>
      _ManageEditProductScreenState();
}

class _ManageEditProductScreenState extends State<ManageEditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = MutableProduct(
      title: '',
      description: '',
      imageUrl: '',
      price: 0,
  );

  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  _updateImageUrl() {
    if ( ! _imageUrlFocusNode.hasFocus) {
      var imageURL = _imageUrlController.text;
      if (getImageValidateError(imageURL) != null) return;

      // it is a bit of a hack: force update state to provide text of _imageUrlController
      // and update our image preview
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  String getImageValidateError(value) {
    var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var result = new RegExp(urlPattern, caseSensitive: false).firstMatch(value);

    if (value.isEmpty) {
      return 'Please provide a value';
    }
    if (result == null) {
      return 'Please enter a valid image url';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
                onSaved: (value) => _editedProduct.title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than 0';
                  }
                  return null;
                },
                onSaved: (value) => _editedProduct.price = double.parse(value)
                // onSaved: (value) => {
                //   _editedProduct = Product(
                //       id: null,
                //       title: _editedProduct.title,
                //       price: double.parse(value),
                //       description: _editedProduct.description,
                //       imageUrl: _editedProduct.imageUrl)
                // },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    if (value.length < 10) {
                      return 'Please enter description with at least 10 symbols';
                    }
                    return null;
                  },
                  onSaved: (value) => _editedProduct.description = value
                  // onSaved: (value) => {
                  //       _editedProduct = Product(
                  //           id: null,
                  //           title: _editedProduct.title,
                  //           price: _editedProduct.price,
                  //           description: value,
                  //           imageUrl: _editedProduct.imageUrl)
                  //     }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter image URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text,
                                fit: BoxFit.cover),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) => getImageValidateError(value),
                        onSaved: (value) => _editedProduct.imageUrl = value,
                        // onSaved: (value) => {
                        //       _editedProduct = Product(
                        //           id: null,
                        //           title: _editedProduct.title,
                        //           price: _editedProduct.price,
                        //           description: _editedProduct.description,
                        //           imageUrl: value)
                        //     }),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
