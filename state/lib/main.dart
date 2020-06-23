import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:state/blocs/allProducts.dart';
import 'package:state/blocs/shoppingCart.dart';

import 'package:state/repositories/product.dart';
import 'package:state/repositories/shoppingCart.dart';

import 'package:state/pages/checkout.dart';
import 'package:state/pages/home.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<ProductRepository>(ProductRepository());
  getIt.registerSingleton<ShoppingCartRepository>(ShoppingCartRepository());

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AllProductBloc()),
    BlocProvider(create: (_) => ShoppingCartBloc()),
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      routes: {
        HomePage.routeName: (_) => HomePage(),
        CheckoutPage.routeName: (_) => CheckoutPage(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
