import 'package:flutter/material.dart';

class CryptoDataColumn extends StatelessWidget {
  CryptoDataColumn({this.childList});

  final List childList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: childList),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
      decoration: BoxDecoration(
        color: Color(0xff00b347),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
