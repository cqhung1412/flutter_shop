import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String name;

  // ProductDetailScreen(this.name);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
      ),
    );
  }
}
