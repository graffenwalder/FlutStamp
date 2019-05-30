import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';

class OrderBookScreen extends StatefulWidget {
  OrderBookScreen(this.selectedMarket);

  final String selectedMarket;
  @override
  _OrderBookScreenState createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
  Map orderBookData = {};

  void getData() async {
    try {
      Map rawData =
          await MarketData().getMarketData('order_book', widget.selectedMarket);
      setState(() {
        orderBookData = rawData;
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
          title: Text('Order Book'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              widget.selectedMarket,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              orderBookData.containsKey('bids')
                  ? orderBookData['bids'][0][0]
                  : 'Waiting for Market Info',
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }
}
