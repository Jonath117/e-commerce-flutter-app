import 'package:app_cart/blocs/cart/cart_event.dart';
import 'package:app_cart/blocs/cart/cart_state.dart';
import 'package:app_cart/core/domain/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) {
    final currentState = state;
    List<CartItem> updatedItems;

    if (currentState is CartUpdated) {
      updatedItems = List<CartItem>.from(currentState.items);
      final existingIndex = updatedItems.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (existingIndex > 0) {
        final existing = updatedItems[existingIndex];
        updatedItems[existingIndex] = CartItem(
          product: event.product,
          quantity: existing.quantity + event.quantity,
        );
      } else {
        updatedItems.add(
          CartItem(product: event.product, quantity: event.quantity),
        );
      }
    } else {
      updatedItems = [
        CartItem(product: event.product, quantity: event.quantity),
      ];
    }
    emit(CartUpdated(items: updatedItems));
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartUpdated) {
      final updatedItems = List<CartItem>.from(currentState.items);
      updatedItems.removeWhere((item) => item.product.id == event.product.id);

      if (updatedItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartUpdated(items: updatedItems));
      }
    }
  }
}
