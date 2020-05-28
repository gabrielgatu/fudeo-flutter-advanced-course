import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "NotoSerif",
        primaryColor: Colors.black,
        primaryColorLight: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: backgroundImage(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: loginPanel(context),
          ),
        ],
      ),
    );
  }

  Widget backgroundImage() => Image.network(
        "https://images.unsplash.com/photo-1510070009289-b5bc34383727?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
        fit: BoxFit.cover,
        color: Colors.grey.shade700,
        colorBlendMode: BlendMode.overlay,
      );

  Widget loginPanel(BuildContext context) => Container(
      padding: EdgeInsets.fromLTRB(30, 40, 30, 10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          headline(),
          SizedBox(height: 5),
          title(),
          SizedBox(height: 10),
          body(),
          SizedBox(height: 20),
          buttons(context),
        ],
      ));

  Widget headline() => Text("Find creative jobs and",
      style: TextStyle(
        fontSize: 16,
      ));

  Widget title() => Text("Express your Best Self.",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ));

  Widget body() =>
      Text("Ideas come from a workspace you enjoy being in and they push you to become a better version of yourself.",
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
          ));

  Widget buttons(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: "Roboto",
              ),
        ),
        child: Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: MaterialButton(
                onPressed: () {},
                height: 50,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColorLight,
                    )),
                child: Text("Login Now",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColorLight,
                    ))),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: MaterialButton(
                onPressed: () {},
                height: 50,
                color: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    )),
                child: Text("Create a New Account",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColor,
                    ))),
          ),
        ]),
      );
}
