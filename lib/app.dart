import 'package:flutter/material.dart';
import 'package:app_cart/features/home/presentation/pages/home_page.dart';
import 'package:app_cart/features/cart/presentation/pages/cart_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => const HomePage(),
        CartPage.route: (context) => const CartPage(),
      },
    );
  }
}
