import 'package:state/models/product.dart';

class ProductRepository {
  Future<List<ProductModel>> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakeProducts;
  }
}

final fakeProducts = [
  ProductModel(
    price: 20.99,
    name: "Pantaloni lino",
    imageUrl: "https://static.bershka.net/4/photos2/2020/I/0/2/p/0261/777/712/01/0261777712_2_7_1.jpg",
  ),
  ProductModel(
    price: 25.99,
    name: "Camicia con stampa di Tom&Jerry",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/0926/777/312/0926777312_2_7_1.jpg",
  ),
  ProductModel(
    price: 45.99,
    name: "Giubbotto Denim Tom&Jerry",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/1332/777/428/01/1332777428_2_7_1.jpg",
  ),
  ProductModel(
    price: 9.99,
    name: "Maglietta con stampa",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/0926/777/312/01/0926777312_2_7_1.jpg",
  ),
  ProductModel(
    price: 25.99,
    name: "Camicia con stampa Tom&Jerry",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/0938/777/627/0938777627_2_7_1.jpg",
  ),
  ProductModel(
    price: 25.99,
    name: "Bermuda denim con strappi",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/2650/335/625/01/2650335625_2_7_1.jpg",
  ),
  ProductModel(
    price: 12.99,
    name: "Costume stampato",
    imageUrl: "https://static.bershka.net/4/photos2/2020/V/0/2/p/4221/305/432/02/4221305432_1_1_1.jpg",
  ),
  ProductModel(
    price: 25.99,
    name: "Bermuda denim jogger",
    imageUrl: "https://static.bershka.net/4/photos2/2020/I/0/2/p/2650/335/712/01/2650335712_2_7_1.jpg",
  ),
];
