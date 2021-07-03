import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mobile/models/models.dart';

class OrdersProvider with ChangeNotifier {
  final String authToken;
  final String userId;
  List<OrderItem> _items = [];

  OrdersProvider(this.authToken, this._items, this.userId);
  
  Future<void> fetchAndSetOrders() async {
    var url = Uri.parse('https://philz-ecommerce-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    
    try {
      final response = await http.get(url);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      // print(responseBody);

      if(responseBody == null) {
        return;
      }

      final List<OrderItem> loadedOrders = [];
      responseBody.forEach((key, value) {
        loadedOrders.add(OrderItem(
          id: key, 
          amount: value['amount'], 
          createdAt: DateTime.parse(value['createdAt']), 
          cartItems: (value['cartItems'] as List<dynamic>).map((item) => CartItem(
            id: item['id'], 
            title: item['title'], 
            quantity: item['quantity'], 
            price: item['price']
          )).toList(), 
        ));
      });

      _items = loadedOrders.reversed.toList();     

      notifyListeners();

    } catch (error) {
      print(error);
      throw error;
    }  
  }

  List<OrderItem> get items {
    return [ ..._items ];
  }

  Future<void> addOrder(List<CartItem> cartItems, double amount) async {
    var url = Uri.parse('https://philz-ecommerce-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final now = DateTime.now();
    try {
      final response = await http.post(url, body: json.encode({
        'cartItems': cartItems.map((cartItem) => {
          'id': cartItem.id,
          'title': cartItem.title,
          'quantity': cartItem.quantity,
          'price': cartItem.price
        }).toList(),
        'amount': amount,
        'createdAt': now.toIso8601String()
      }));

      final responseBody = json.decode(response.body);

      _items.insert(0, OrderItem(
        id: responseBody['name'],  
        cartItems: cartItems,
        amount: amount,
        createdAt: now
      ));

      notifyListeners();

    } catch (error) {
      print(error);
      throw error;
    }  
  }

  void clearOrders() {
    _items = [];
  }
}