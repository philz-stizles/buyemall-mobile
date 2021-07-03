import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({ // Since there is one field(i.e isFavorite) that is free to change after build, 
  // we cannot define the constructor with const 
    @required this.id, 
    @required this.title, 
    @required this.description,
    @required this.price,
    this.isFavorite = false,
    @required this.imageUrl, 
  });

  Future<void> toggleIsFavorite(String authToken, String userId) async {
    final url = Uri.parse('https://philz-ecommerce-default-rtdb.firebaseio.com/favorites/$userId/$id.json?auth=$authToken');
    final oldFavoriteStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if(response.statusCode >= 400) {
        isFavorite = oldFavoriteStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldFavoriteStatus;
      notifyListeners();
    }
  }
}
