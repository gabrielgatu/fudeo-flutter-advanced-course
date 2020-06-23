import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state/blocs/shoppingCart.dart';

import 'package:state/models/product.dart';

class CheckoutPage extends StatelessWidget {
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  Widget appBar(BuildContext context) => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Il mio ordine"),
        centerTitle: true,
      );

  Widget body(BuildContext context) =>
      BlocConsumer<ShoppingCartBloc, ShoppingCartStateLoaded>(listener: (context, shoppingCart) {
        final products = shoppingCart.products;
        if (products.isEmpty) Navigator.pop(context);
      }, builder: (context, shoppingCart) {
        final products = shoppingCart.products;
        final totalCost = products.length > 0 ? products.map((it) => it.price).reduce((a, b) => a + b) : 0.0;

        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(child: shoppingCartProductList(context, products)),
            SizedBox(height: 20),
            footer(totalCost),
          ]),
        );
      });

  Widget shoppingCartProductList(BuildContext context, List<ProductModel> products) => ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) => product(context, products[index]),
        separatorBuilder: (_, __) => SizedBox(height: 20),
      );

  Widget product(BuildContext context, ProductModel product) => Row(children: <Widget>[
        Container(
          width: 120,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 10),
            Text("€ ${product.price}", style: TextStyle(fontSize: 18, color: Colors.black45)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartEventRemoveProduct(product));
              },
              child: Row(children: <Widget>[
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(width: 10),
                Text("Tap per togliere", style: TextStyle(color: Colors.black38)),
              ]),
            ),
          ]),
        ),
      ]);

  Widget footer(double total) => Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text("Totale", style: TextStyle(fontSize: 20))),
            Text("€ $total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 20),
        MaterialButton(
          onPressed: () {},
          minWidth: double.infinity,
          height: 50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.black,
          textColor: Colors.white,
          child: Text("Vai al pagamento"),
        ),
      ]);
}
