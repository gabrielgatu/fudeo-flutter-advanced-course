import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state/main.dart';
import 'package:state/models/product.dart';
import 'package:state/repositories/product.dart';

class AllProductBloc extends Bloc<AllProductsEvent, AllProductsState> {
  @override
  AllProductsState get initialState => AllProductsStateLoading();

  @override
  Stream<AllProductsState> mapEventToState(AllProductsEvent event) async* {
    if (event == AllProductsEvent.Get) {
      final products = await getIt<ProductRepository>().all();
      yield AllProductsStateLoaded(products);
    }
  }
}

enum AllProductsEvent { Get }

abstract class AllProductsState {}

class AllProductsStateLoading extends AllProductsState {}

class AllProductsStateLoaded extends AllProductsState {
  AllProductsStateLoaded(this.products);
  final List<ProductModel> products;
}
