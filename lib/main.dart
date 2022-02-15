import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_shopping_cart/models/Cart.dart';
import 'package:simple_shopping_cart/models/User.dart';
import 'package:simple_shopping_cart/provider/product_provider.dart';
import 'package:simple_shopping_cart/screens/cart.dart';
import 'package:simple_shopping_cart/screens/catalog.dart';
import 'package:simple_shopping_cart/screens/loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'common/theme.dart';
import 'screens/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: CartModel()),
        ChangeNotifierProvider.value(value: User()),
      ],
      child: const MyApp(),
    ),
  );
  configLoading();
}

const spinKit = SpinKitRotatingCircle(
  color: Colors.yellow,
  size: 50.0,
);

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..userInteractions = true
    ..dismissOnTap = false
    ..indicatorWidget = spinKit;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: appTheme,
      routes: {
        '/': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/cart': (context) => const CartScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
