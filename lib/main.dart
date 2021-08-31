import 'package:flutter/material.dart';

import './styles/my_colors.dart';
import './screens/product_overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: MyColors.Mauve,
        accentColor: MyColors.Sapphire,
        fontFamily: 'Lato',
      ),
      home: ProductOverview(),
    );
  }
}
