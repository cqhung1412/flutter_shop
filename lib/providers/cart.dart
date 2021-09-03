import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final double pricePerUnit;
  int quantity;

  CartItem(
      {required this.id,
      required this.name,
      required this.pricePerUnit,
      this.quantity = 1});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((_, item) {
      total += item.pricePerUnit * item.quantity;
    });
    return total;
  }

  void addItem(String productId, String name, double price) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (value) {
        value.quantity += 1;
        return value;
      });
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(id: productId, name: name, pricePerUnit: price));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    var cartItem = _items[productId];
    if (cartItem!.quantity == 1) {
      _items.remove(productId);
    } else {
      cartItem.quantity -= 1;
    }
    notifyListeners();
  }

  void removeFullItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
