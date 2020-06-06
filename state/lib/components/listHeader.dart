import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  ListHeader(this.parts) : assert(parts.length == 2);
  final List<String> parts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(parts[0], style: TextStyle(fontSize: 30)),
        Text(parts[1], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
