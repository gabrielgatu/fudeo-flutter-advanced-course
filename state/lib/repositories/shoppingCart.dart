import 'package:state/models/product.dart';

class ShoppingCartRepository {
  final List<ProductModel> products = [];

  List<ProductModel> addProduct(ProductModel product) {
    return products..add(product);
  }

  List<ProductModel> removeProduct(ProductModel product) {
    return products..remove(product);
  }

  bool contains(ProductModel product) {
    return products.contains(product);
  }
}
