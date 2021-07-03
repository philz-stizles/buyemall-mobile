import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {}; // A

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.quantity * cartItem.price);
    });

    return total;
  }

  void addItemToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (currentValue) {
        return CartItem(
            id: currentValue.id,
            title: currentValue.title,
            quantity: currentValue.quantity + 1,
            price: currentValue.price);
      });
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }

    notifyListeners();
  }

  void removeItemFromCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    _items.remove(productId);
    notifyListeners();
  }

  void undoAddItemToCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(productId, (currentValue) {
        return CartItem(
            id: currentValue.id,
            title: currentValue.title,
            quantity: currentValue.quantity - 1,
            price: currentValue.price);
      });
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
