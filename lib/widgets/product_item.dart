import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  ProductItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: id,
            );
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(name),
            //   ),
            // );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_basket,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
