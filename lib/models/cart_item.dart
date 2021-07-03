import 'package:flutter/material.dart';

class CartItem {
  final String id; // Every CartItem should have a unique id. 
  // The productId will be the key of the cart Map<String, CartItem>
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    @required this.id, 
    @required this.title, 
    @required this.quantity, 
    @required this.price,
  });
}