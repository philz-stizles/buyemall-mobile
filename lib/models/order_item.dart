import 'package:flutter/material.dart';
import 'package:mobile/models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime createdAt;

  const OrderItem(
      {@required this.id,
      @required this.cartItems,
      @required this.amount,
      @required this.createdAt});
}
