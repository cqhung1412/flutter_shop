import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double pricePerUnit;
  final int quantity;
  final String name;

  CartItem(this.id, this.name, this.pricePerUnit, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$pricePerUnit'),
              ),
            ),
          ),
          title: Text(name),
          subtitle: Text('Total: \$${pricePerUnit * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
