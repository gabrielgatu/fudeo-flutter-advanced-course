import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state/main.dart';
import 'package:state/models/product.dart';
import 'package:state/repositories/shoppingCartRepository.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  @override
  ShoppingCartState get initialState => ShoppingCartStateLoaded([]);

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    print(event);
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

abstract class ShoppingCartState {}

class ShoppingCartStateLoaded extends ShoppingCartState {
  ShoppingCartStateLoaded(this.products);
  final List<ProductModel> products;
}
