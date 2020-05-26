import 'package:flutter/material.dart';

import 'package:routing/models/mail.dart';

class DetailPageArgs {
  DetailPageArgs({@required this.mail, @required this.color});

  MailModel mail;
  Color color;
}

class DetailPage extends StatelessWidget {
  static String routeName = "/mail/detail";

  @override
  Widget build(BuildContext context) {
    final DetailPageArgs args = ModalRoute.of(context).settings.arguments;
    final mail = args.mail;
    final color = args.color;

    return Scaffold(
        appBar: AppBar(
          title: Text(mail.title),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                radius: 25,
                backgroundColor: color,
                child: Text(mail.title.substring(0, 2).toUpperCase(), style: TextStyle(color: Colors.white))),
            title: Text(mail.title),
            subtitle: Text(mail.content, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.reply),
            ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(mail.content, style: TextStyle(height: 1.4)),
          )
        ]));
  }
}
