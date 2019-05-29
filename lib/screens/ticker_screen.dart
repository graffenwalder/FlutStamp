import 'package:flutter/material.dart';

class TickerScreen extends StatelessWidget {
  TickerScreen(this.selectedMarket);
  final String selectedMarket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ticker Info'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              selectedMarket,
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }
}
