import 'package:flutter/foundation.dart';
import 'package:flutter_shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double totalPrice;
  final List<CartItem> products;
  DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.totalPrice,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [...items];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _items.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        totalPrice: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
