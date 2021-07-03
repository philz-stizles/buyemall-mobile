import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price, rating;
  final String imageUrl;
  final List<String> images;
  final List<Color> colors;
  bool isFavorite, isPopular;

  Product({
    // Since there is one field(i.e isFavorite) that is free to change after build,
    // we cannot define the constructor with const
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    this.isFavorite = false,
    this.isPopular = false,
    this.imageUrl,
    this.images,
    @required this.colors,
    this.rating = 0.0,
  });

  Future<void> toggleIsFavorite(String authToken, String userId) async {
    final url = Uri.parse(
        'https://philz-ecommerce-default-rtdb.firebaseio.com/favorites/$userId/$id.json?auth=$authToken');
    final oldFavoriteStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        isFavorite = oldFavoriteStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldFavoriteStatus;
      notifyListeners();
    }
  }
}

List<Product> demoProducts = [
  Product(
    id: '1',
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavorite: true,
    isPopular: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: '3',
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavorite: true,
    isPopular: true,
  ),
  Product(
    id: '4',
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavorite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";