import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p2',
      name: 'Kana Momonogi',
      description: 'A nice pair of ...',
      price: 59.99,
      imageUrl:
          'https://gamek.mediacdn.vn/thumb_w/640/133514250583805952/2020/5/27/-15905513653851678901709.jpg',
    ),
    Product(
      id: 'p1',
      name: 'Arina Hashimoto',
      description: 'It is pretty red!',
      price: 29.99,
      imageUrl:
          'https://gamek.mediacdn.vn/133514250583805952/2020/6/17/photo-1-15924015006991181398792.jpg',
    ),
    Product(
      id: 'p4',
      name: 'Yua Mikami',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://cdn.hit.vn/toquoc/55309ff1-1d3d-4478-4ba6-076f9fd0d28b/5d4b8d81-f3b2-42d2-40b9-a4b2001fb7ba.jpg',
    ),
    Product(
      id: 'p3',
      name: 'Eimi Fukada',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://gamek.mediacdn.vn/133514250583805952/2021/6/15/photo-1-16237578241171154845758.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
