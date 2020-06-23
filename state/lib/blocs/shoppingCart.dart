import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state/main.dart';
import 'package:state/models/product.dart';
import 'package:state/repositories/shoppingCart.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartStateLoaded> {
  @override
  ShoppingCartStateLoaded get initialState => ShoppingCartStateLoaded(
        getIt<ShoppingCartRepository>().products,
      );

  @override
  Stream<ShoppingCartStateLoaded> mapEventToState(ShoppingCartEvent event) async* {
    if (event is ShoppingCartEventAddProduct) {
      final product = event.product;
      final products = getIt<ShoppingCartRepository>().addProduct(product);
      yield ShoppingCartStateLoaded(products);
    } else if (event is ShoppingCartEventRemoveProduct) {
      final product = event.product;
      final products = getIt<ShoppingCartRepository>().removeProduct(product);
      yield ShoppingCartStateLoaded(products);
    }
  }
}

abstract class ShoppingCartEvent {}

class ShoppingCartEventAddProduct extends ShoppingCartEvent {
  ShoppingCartEventAddProduct(this.product);
  final ProductModel product;
}

class ShoppingCartEventRemoveProduct extends ShoppingCartEvent {
  ShoppingCartEventRemoveProduct(this.product);
  final ProductModel product;
}

class ShoppingCartStateLoaded {
  ShoppingCartStateLoaded(this.products);
  final List<ProductModel> products;
}
