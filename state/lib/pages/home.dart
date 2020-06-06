import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state/blocs/allProducts.dart';
import 'package:state/blocs/shoppingCart.dart';
import 'package:state/components/listHeader.dart';

import 'package:state/models/product.dart';
import 'package:state/pages/checkout.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllProductBloc>(context).add(AllProductsEvent.Get);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() => CustomScrollView(
        slivers: <Widget>[
          appBar(),
          listHeader(),
          gridProducts(),
        ],
      );

  Widget appBar() => SliverAppBar(
        elevation: 0,
        floating: true,
        actions: <Widget>[
          shoppingCardIcon(),
        ],
      );

  Widget shoppingCardIcon() => BlocBuilder<ShoppingCartBloc, ShoppingCartState>(builder: (context, shoppingCart) {
        final productsInShoppingCard = (shoppingCart as ShoppingCartStateLoaded).products.length;
        return Stack(
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                CheckoutPage.routeName,
              ),
              icon: Icon(Icons.shopping_cart),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(productsInShoppingCard.toString(), style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        );
      });

  Widget listHeader() => SliverToBoxAdapter(
        child: Padding(padding: EdgeInsets.all(20), child: ListHeader(["Our", "Products"])),
      );

  Widget gridProducts() => BlocBuilder<AllProductBloc, AllProductsState>(builder: (context, state) {
        if (state is AllProductsStateLoading)
          return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        else {
          final products = (state as AllProductsStateLoaded).products;
          return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(builder: (context, shoppingCart) {
            return SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              children: List.generate(products.length, (index) {
                final product = products[index];
                final isProductInShoppingCart = (shoppingCart as ShoppingCartStateLoaded).products.contains(product);
                return buildProduct(product, isProductInShoppingCart);
              }),
            );
          });
        }
      });

  Widget buildProduct(ProductModel product, bool isProductInShoppingCart) => GestureDetector(
        onTap: () {
          print("tapped");
          if (isProductInShoppingCart)
            BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartEventRemoveProduct(product));
          else
            BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartEventAddProduct(product));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(product.name, style: TextStyle()),
                        SizedBox(height: 5),
                        Text("€ ${product.price}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.favorite, color: isProductInShoppingCart ? Colors.red : Colors.black12),
                ],
              )
            ],
          ),
        ),
      );
}
