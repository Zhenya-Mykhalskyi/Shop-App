import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
//   https://nashaplaneta.net/fruits/images/kiwano.jpg

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
      imageUrl:
          'http://cdn.shopify.com/s/files/1/2971/2126/products/Papaya_c249393e-13b2-4993-b8a0-63ca212b9bca.jpg',
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
      description: '1 kg of delicious avocado.',
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
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/dragon-fruit-pitaya-white-exoticfruitscouk-988200_1024x1024@2x.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Carambola',
      description: ' 1 kg of delicious carambola',
      price: 15.49,
      imageUrl: 'https://nashaplaneta.net/fruits/images/star_fruit.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Banana-Apple',
      description: ' 1 kg of delicious banana-apple',
      price: 14.49,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/banana-apple-manzano-exoticfruitscouk-905674_1024x1024@2x.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Yellow-Pitahaya',
      description: ' 1 kg of delicious yellow pitahaya',
      price: 21.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/dragon-fruit-yellow-pitahaya-exoticfruitscouk-198694_1024x1024@2x.jpg',
    ),
    Product(
      id: 'p10',
      title: 'Jackfruit',
      description: ' 1 kg of delicious jackfruit',
      price: 23.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/jackfruit-exoticfruitscouk-417432_1024x1024@2x.jpg',
    ),
    Product(
      id: 'p11',
      title: 'Kiwi-Berry',
      description: ' 1 kg of delicious kiwwi-berry',
      price: 18.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/kiwi-berry-exoticfruitscouk-146243_1024x1024@2x.jpg',
    ),
  ];

  // var _showFavoritesOnly = false;

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

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://exotic-fruits-shop-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'], //id from firebase server
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); //to add product at the start of the list
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      // print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
