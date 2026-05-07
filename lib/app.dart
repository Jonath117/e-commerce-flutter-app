import 'package:app_cart/blocs/cart/cart_bloc.dart';
import 'package:app_cart/features/cart/presentation/pages/cart_page.dart';
import 'package:app_cart/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. El BlocProvider envuelve a toda la aplicación
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc(),
      // 2. El hijo debe ser el MaterialApp
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
