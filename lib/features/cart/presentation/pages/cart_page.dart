// lib/features/cart/presentation/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cart/blocs/cart/cart_bloc.dart';
import 'package:app_cart/blocs/cart/cart_state.dart';
import 'package:app_cart/blocs/cart/cart_event.dart';
import 'package:app_cart/core/notifiers/cart_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cart/features/home/presentation/pages/home_page.dart';

class CartPage extends StatelessWidget {
  // Volvemos a StatelessWidget (tu base)
  static const String route = '/cart';

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos ambos estados
    final cartNotifier = context.watch<CartNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(HomePage.route),
        ),
      ),

      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final items = cartNotifier.cart;

          if (items.isEmpty) {
            return const Center(
              child: Text(
                'El carrito está vacío',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(
                        item.product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.product.name),
                      subtitle: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => cartNotifier.updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            ),
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => cartNotifier.updateQuantity(
                              item.product.id,
                              item.quantity + 1,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Borramos en Notifier
                              cartNotifier.removeProduct(item.product.id);
                              // Borramos en Bloc para mantener sincronía
                              context.read<CartBloc>().add(
                                RemoveProduct(product: item.product),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${cartNotifier.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
