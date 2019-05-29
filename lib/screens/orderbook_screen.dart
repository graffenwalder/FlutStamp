import 'package:flutter/material.dart';

class OrderBookScreen extends StatelessWidget {
  OrderBookScreen(this.selectedMarket);
  final String selectedMarket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Book'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            selectedMarket,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
