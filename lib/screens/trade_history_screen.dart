import 'package:flutter/material.dart';

class TradeHistoryScreen extends StatelessWidget {
  TradeHistoryScreen(this.selectedMarket);
  final String selectedMarket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade History'),
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
