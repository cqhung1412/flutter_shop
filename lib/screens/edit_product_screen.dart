import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formStateKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    name: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  var _initValues = {
    'name': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  bool _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId.toString() != 'null') {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _initValues = {
          'name': _editedProduct.name,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      var url = _imageUrlController.text;
      if (url.isEmpty ||
          !url.startsWith(RegExp(
            r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
            caseSensitive: false,
          )) ||
          !url.endsWith('.png') ||
          !url.endsWith('.jpg') ||
          !url.endsWith('.jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_formStateKey.currentState!.validate()) return;
    _formStateKey.currentState!.save();
    if (_editedProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  void _updateProduct(String field, String value) {
    _editedProduct = Product(
      id: _editedProduct.id,
      name: (field == 'name') ? value : _editedProduct.name,
      price: (field == 'price') ? double.parse(value) : _editedProduct.price,
      description:
          (field == 'description') ? value : _editedProduct.description,
      imageUrl: (field == 'imageUrl') ? value : _editedProduct.imageUrl,
      isFavorite: _editedProduct.isFavorite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formStateKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['name'],
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      Focus.of(context).requestFocus(_priceFocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pls enter a product\'s name!';
                    }
                    return null;
                  },
                  onSaved: (value) => _updateProduct('name', value.toString()),
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) =>
                      Focus.of(context).requestFocus(_descFocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pls enter a price!';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Pls enter a valid number!';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Pls enter a number greater than zero!';
                    }
                    return null;
                  },
                  onSaved: (value) => _updateProduct('price', value.toString()),
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pls enter a description for your product!';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters!';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      _updateProduct('description', value.toString()),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter an URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter an image URL!';
                          }
                          if (!value.startsWith(RegExp(
                            r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
                            caseSensitive: false,
                          ))) {
                            return 'Pls enter a valid image URL!';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _updateProduct('imageUrl', value.toString()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
