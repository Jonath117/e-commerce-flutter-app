import 'package:app_cart/core/domain/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_cart/core/data/dummy_data.dart';
import 'package:app_cart/features/product_detail/presentation/pages/product_details_page.dart';
import 'package:app_cart/features/cart/presentation/pages/cart_page.dart';
import 'package:app_cart/core/notifiers/cart_notifier.dart';
import '../widgets/product_card_widget.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  final List<CartItem> initialCart;

  const HomePage({
    super.key,
    this.initialCart = const [],
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

  final cartNotifier = context.read<CartNotifier>();
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce'),
        actions: [
          ListenableBuilder(
            listenable: cartNotifier, builder: 
            (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      context.go(CartPage.route);
                    },
                  ),
                  if (cartNotifier.cart.isNotEmpty)
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
                          '${cartNotifier.cartItemsCount}',
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
              );
            }
          )
          
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
                context.push(
                  ProductDetailsPage.route,
                  extra: {
                    'product': product,
                    'onAddToCart': cartNotifier.addToCart,
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}