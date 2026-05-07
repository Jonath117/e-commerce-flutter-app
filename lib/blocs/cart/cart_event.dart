import 'package:app_cart/core/domain/product.dart';

abstract class CartEvent {}

class AddProduct extends CartEvent {
  final Product product;
  final int quantity;

  AddProduct({required this.product, this.quantity = 1});
}

class RemoveProduct extends CartEvent {
  final Product product;

  RemoveProduct({required this.product});
}
