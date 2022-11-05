import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Kiwano Melon',
      description: '1 kg of delicious kiwano melon',
      price: 15.99,
      imageUrl: 'https://nashaplaneta.net/fruits/images/kiwano.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Papaya',
      description: '1 kg of delicious papaya.',
      price: 11.49,
      imageUrl: 'https://nashaplaneta.net/fruits/images/papaya.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Grapefruit',
      description: '1 kg of delicious grapefruit.',
      price: 1.99,
      imageUrl: 'https://delikates.ua/images/product/greyfrut.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Avocado',
      description: '1 kilo of delicious avocado.',
      price: 2.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/2019/9113/collections/Avocado.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Pineapple Guava',
      description: '1 kg of delicious pineapple Guava.',
      price: 18.99,
      imageUrl: 'https://nashaplaneta.net/fruits/images/feihoa.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Dragon fruit',
      description: '1 kg of delicious dragon fruit.',
      price: 12.99,
      imageUrl: 'https://nashaplaneta.net/fruits/images/dragon_fruit.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Carambola',
      description: ' 1 kg of delicious carambola',
      price: 15.49,
      imageUrl: 'https://nashaplaneta.net/fruits/images/star_fruit.jpg',
    ),
  ];

  var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); //to add product at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
