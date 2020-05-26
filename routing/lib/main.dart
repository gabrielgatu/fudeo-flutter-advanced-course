import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:routing/pages/detail.dart';
import 'package:routing/pages/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      routes: {
        DetailPage.routeName: (context) => DetailPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailPage.routeName) {
          return PageTransition(
            type: PageTransitionType.downToUp,
            child: DetailPage(),
            settings: settings,
          );
        } else
          return null;
      },
      home: HomePage(),
    );
  }
}
