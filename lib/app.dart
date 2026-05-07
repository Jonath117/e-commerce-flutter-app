import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_cart/core/domain/cart_item.dart';
import 'package:app_cart/core/domain/product.dart';
import 'package:app_cart/features/cart/presentation/pages/add_to_cart_page.dart';
import 'package:app_cart/features/product_detail/presentation/pages/product_details_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'core/notifiers/cart_notifier.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomePage.route,
  routes: [
    GoRoute(
      path: HomePage.route,
      builder: (context, state) {
        final cart = state.extra as List<CartItem>? ?? <CartItem>[];
        return HomePage(initialCart: cart);
      },
    ),
    GoRoute(
      path: CartPage.route,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: ProductDetailsPage.route,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final product = extra?['product'] as Product?;
        final onAddToCart = extra?['onAddToCart'] as void Function(Product, int)?;

        if (product == null || onAddToCart == null) {
          return const Scaffold(
            body: Center(child: Text('Faltan argumentos para ProductDetailsPage')),
          );
        }

        return ProductDetailsPage(
          product: product,
          onAddToCart: onAddToCart,
        );
      },
    ),
    GoRoute(
      path: AddToCartPage.route,
      builder: (context, state) => const AddToCartPage(),
    ),
  ],
);


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartNotifier(),
      child: MaterialApp.router(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: appRouter
      ),
    );
  }
}