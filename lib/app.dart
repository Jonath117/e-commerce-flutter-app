import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'core/notifiers/cart_notifier.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartNotifier(),
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (context) => const HomePage(),
          CartPage.route: (context) => const CartPage(),
        },
      ),
    );
  }
}
