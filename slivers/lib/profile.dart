import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
          appBar(context),
          sectionTitle("My photos"),
          listPhotos(),
          sectionTitle("My contacts"),
          contacts(),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) => SliverAppBar(
        title: Text("My awesome contact"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        expandedHeight: 350,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            "asset/elon.jpg",
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget sectionTitle(String title) => SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16, 25, 0, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
      ));

  Widget listPhotos() => SliverPadding(
        padding: EdgeInsets.only(top: 3),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          delegate:
              SliverChildBuilderDelegate((context, index) => photo(_photos[index % (_photos.length)]), childCount: 30),
        ),
      );

  Widget photo(String photoUrl) => Image.network(photoUrl, fit: BoxFit.cover);

  Widget contacts() => SliverPadding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          contactButton(text: "Instagram", color: Colors.deepPurple),
          contactButton(text: "Facebook", color: Colors.indigo),
          contactButton(text: "Twitter", color: Colors.blue),
        ]),
      ));

  Widget contactButton({@required String text, @required Color color}) => MaterialButton(
        onPressed: () {},
        minWidth: double.infinity,
        height: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: color,
        textColor: Colors.white,
        child: Text(text),
      );
}
