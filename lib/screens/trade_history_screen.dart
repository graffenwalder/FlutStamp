import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';

class TradeHistoryScreen extends StatefulWidget {
  TradeHistoryScreen(this.selectedMarket);

  final String selectedMarket;

  @override
  _TradeHistoryScreenState createState() => _TradeHistoryScreenState();
}

class _TradeHistoryScreenState extends State<TradeHistoryScreen> {
  List tradeHistoryData = [];

  void getData() async {
    try {
      List rawData = await MarketData()
          .getMarketData('transactions', widget.selectedMarket);
      setState(() {
        tradeHistoryData = rawData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trade History'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              widget.selectedMarket,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              tradeHistoryData.length > 0
                  ? tradeHistoryData[0]['price']
                  : 'Waiting for Market Info',
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }
}
