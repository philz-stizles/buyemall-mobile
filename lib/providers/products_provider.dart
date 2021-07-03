import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/models.dart';

class ProductsProvider with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Product> _items = [];

  ProductsProvider(this.authToken, this._items, this.userId);

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filter = filterByUser ? '&orderBy="creator"&equalTo="$userId"' : '';
    try {
      var url = Uri.parse(
          'https://philz-ecommerce-default-rtdb.firebaseio.com/products.json?auth=$authToken$filter');
      final productsResponse = await http.get(url);
      final productsResponseBody =
          json.decode(productsResponse.body) as Map<String, dynamic>;
      // print(productsResponseBody);

      if (productsResponseBody == null) {
        return;
      }

      url = Uri.parse(
          'https://philz-ecommerce-default-rtdb.firebaseio.com/favorites/$userId.json?auth=$authToken');
      final favoritesResponse = await http.get(url);
      final favoritesResponseBody =
          json.decode(favoritesResponse.body) as Map<String, dynamic>;

      final List<Product> loadedProducts = [];
      productsResponseBody.forEach((key, value) {
        loadedProducts.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            isFavorite: (favoritesResponseBody == null)
                ? false
                : favoritesResponseBody[key] ?? false,
            imageUrl: value['imageUrl']));
      });

      _items = loadedProducts;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((p) => p.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://philz-ecommerce-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creator': userId
          }));

      final responseBody = json.decode(response.body);
      final newProduct = Product(
          id: responseBody['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((item) => item.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://philz-ecommerce-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));

      // final responseBody = json.decode(response.body);
      // print(responseBody);
      _items[productIndex] = product;

      notifyListeners();
    } else {
      print('Not found in local  items');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse(
        'https://philz-ecommerce-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken');

    await http.delete(url);
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  Future<void> optimisticDeleteProduct(String productId) async {
    final url = Uri.parse(
        'https://philz-ecommerce-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken');
    final existingProductIndex =
        _items.indexWhere((item) => item.id == productId);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }

    existingProduct = null;
  }
}
