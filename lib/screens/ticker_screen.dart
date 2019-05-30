import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';
import 'package:flut_stamp/components/menu_item.dart';
import 'package:flut_stamp/screens/orderbook_screen.dart';
import 'package:flut_stamp/screens/trade_history_screen.dart';

class TickerScreen extends StatefulWidget {
  TickerScreen(this.selectedMarket);
  final String selectedMarket;
  @override
  _TickerScreenState createState() => _TickerScreenState();
}

class _TickerScreenState extends State<TickerScreen> {
  Map marketInfo = {};

  void getData() async {
    try {
      Map rawData =
          await MarketData().getMarketData('ticker', widget.selectedMarket);
      setState(() {
        marketInfo = rawData;
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
          title: Text('Ticker Info'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.selectedMarket,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              marketInfo.containsKey('last')
                  ? marketInfo['last']
                  : 'Waiting for Market Info',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 200.0,
            ),
            MenuItemCard(
              menuText: 'Orderbook Info',
              screen: OrderBookScreen(widget.selectedMarket),
            ),
            MenuItemCard(
              menuText: 'Trade History',
              screen: TradeHistoryScreen(widget.selectedMarket),
            )
          ],
        ));
  }
}
