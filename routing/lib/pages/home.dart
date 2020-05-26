import 'package:flutter/material.dart';

import 'package:routing/models/mail.dart';

import 'package:routing/pages/detail.dart';

class HomePage extends StatelessWidget {
  final colors = [
    Colors.indigo,
    Colors.blue,
    Colors.deepPurple,
    Colors.red,
    Colors.deepOrange,
    Colors.teal,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Primary"),
        centerTitle: true,
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
      ),
      body: ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) => mailRow(context, mails[index], index),
      ),
    );
  }

  Widget mailRow(BuildContext context, MailModel mail, int index) {
    final color = colors[index % colors.length];

    return ListTile(
      onTap: () => {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: DetailPageArgs(mail: mail, color: color),
        )
      },
      leading: CircleAvatar(
          radius: 25,
          backgroundColor: color,
          child: Text(mails[index].title.substring(0, 2).toUpperCase(), style: TextStyle(color: Colors.white))),
      title: Text(mail.title),
      subtitle: Text(mail.content, overflow: TextOverflow.ellipsis),
      trailing: Text(mail.date, style: TextStyle(color: Colors.grey.shade500)),
    );
  }
}

final mails = List.generate(
    100,
    (_) => MailModel(
          title: "American Express",
          content:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec molestie tortor augue, viverra scelerisque elit porttitor in. Suspendisse aliquet ante quis quam dictum suscipit. Pellentesque mauris urna, tempor sit amet finibus vitae, rutrum scelerisque erat. Etiam leo turpis, malesuada eget nisi nec, tempus auctor lectus. Nullam eleifend nibh vitae ante malesuada, eget aliquam nulla luctus. Nunc non pretium mi. Cras sagittis maximus dictum. Nullam ornare aliquam eros. Curabitur augue mauris, pulvinar in porttitor eu, hendrerit non dui. Nulla ac interdum ante.",
          date: "23 May",
        ));
