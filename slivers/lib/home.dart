import 'package:flutter/material.dart';

import 'profile.dart';

class HomePage extends StatelessWidget {
  final _photos = [
    "https://www.ilriformista.it/wp-content/uploads/2020/05/LP_11314766-900x600.jpg",
    "https://www.repstatic.it/content/nazionale/img/2020/05/08/154935606-f358f4ca-8d0c-458a-a290-52792dc67d91.jpg",
    "https://www.repstatic.it/content/nazionale/img/2020/04/30/113058468-76f9f56d-b6e4-478d-9ba7-1841faa6b6a1.jpg",
    "https://www.ilpost.it/wp-content/uploads/2019/12/musk.jpg",
    "https://www.firstradioweb.com/wp-content/uploads/2020/05/elon-musk-contro-tutti-per-riaprire-le-fabbriche-di-tesla.jpg",
    "https://leganerd.com/wp-content/uploads/2020/02/5e32fe1562fa81399f121b85-999x749.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar(),
          contactList(context),
        ],
      ),
    );
  }

  Widget appBar() => SliverAppBar(
        title: Text("Telegram dark"),
        centerTitle: false,
        floating: true,
        snap: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.dehaze),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      );

  Widget contactList(BuildContext context) => SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) => contactRow(context, _photos[index % _photos.length]),
        childCount: 100,
      ));

  Widget contactRow(BuildContext context, String photoUrl) => ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
        leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(photoUrl)),
        title: Text("My awesome contact"),
        subtitle: Text("What's up mate!"),
        trailing: Text("2 days ago", style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
      );
}
