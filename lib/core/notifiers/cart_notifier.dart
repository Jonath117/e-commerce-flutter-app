import 'package:app_cart/core/domain/cart_item.dart';
import 'package:flutter/material.dart';

import '../domain/product.dart';

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(Product product, int quantity) {
    final existingIndex = cart.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final existingItem = cart[existingIndex];
      cart[existingIndex] = CartItem(
        product: product,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      cart.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
  }

  void removeProduct(String productId) {
    _cart.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  
  void updateQuantity(String productId, int newQuantity) {
    final index = _cart.indexWhere((item) => item.product.id == productId);
        
    if(index < 0) {
      return;
    }

    if (newQuantity <= 0) {
      removeProduct(productId);
    } else {
      _cart[index] = CartItem(
        product: _cart[index].product,
        quantity: newQuantity,
      );
      notifyListeners();
    }
      
  }
  
  int get cartItemsCount {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return cart.fold(0, (sum, item) => sum + item.totalPrice);
  }
}