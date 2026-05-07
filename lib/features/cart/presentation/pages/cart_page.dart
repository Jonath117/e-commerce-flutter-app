import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cart/core/domain/cart_item.dart';
import 'package:app_cart/features/home/presentation/pages/home_page.dart';

class CartPage extends StatefulWidget {
  static const String route = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = GoRouterState.of(context).extra as List<CartItem>?;
    cart = args != null ? List.from(args) : [];
  }

  double get totalPrice {
    return cart.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void _goBackHome() {
    context.go(HomePage.route, extra: cart);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic result) {
        if (didPop) return;
        _goBackHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Carrito'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _goBackHome,
          ),
        ),
        body: cart.isEmpty
            ? const Center(
                child: Text(
                  'El carrito está vacío',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          leading: Image.network(
                            item.product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            'Cantidad: ${item.quantity}  -  \$${item.totalPrice.toStringAsFixed(2)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                cart.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
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
                          '\$${totalPrice.toStringAsFixed(2)}',
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
              ),
      ),
    );
  }
}