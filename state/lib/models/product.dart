import 'package:flutter/foundation.dart';

class ProductModel {
  ProductModel({
    @required this.imageUrl,
    @required this.name,
    @required this.price,
  });

  final String imageUrl;
  final String name;
  final double price;
}
