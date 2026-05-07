import 'package:flutter/material.dart';
import 'package:app_cart/core/data/dummy_data.dart';
import 'package:app_cart/core/domain/cart_item.dart';
import 'package:app_cart/core/domain/product.dart';
import 'package:app_cart/features/product_detail/presentation/pages/product_details_page.dart';
import 'package:app_cart/features/cart/presentation/pages/cart_page.dart';
import '../widgets/product_card_widget.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CartItem> cart = [];

  int get cartItemsCount {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      final existingIndex = cart.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (existingIndex >= 0) {
        final existingItem = cart[existingIndex];
        cart[existingIndex] = CartItem(
          product: product,
          quantity: existingItem.quantity + quantity,
        );
      } else {
        cart.add(CartItem(product: product, quantity: quantity));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  final updatedCart =
                      await Navigator.pushNamed(
                            context,
                            CartPage.route,
                            arguments: cart,
                          )
                          as List<CartItem>?;

                  if (updatedCart != null && mounted) {
                    setState(() {
                      cart.clear();
                      cart.addAll(updatedCart);
                    });
                  }
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemsCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: dummyProducts.length,
          itemBuilder: (context, index) {
            final product = dummyProducts[index];
            return ProductCardWidget(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      product: product,
                      onAddToCart: _addToCart,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
