import 'package:app_cart/core/domain/cart_item.dart';
//informacion que la UI necesita para dibujar

abstract class CartState {}

class CartEmpty extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;

  CartUpdated({required this.items});

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
