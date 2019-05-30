import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';
import 'package:flut_stamp/constants.dart';
import 'package:flut_stamp/components/data_column.dart';

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

  List<Text> getTransactions() {
    if (tradeHistoryData.length > 0) {
      List<Text> appendList = [];
      for (int i = 0; i < 25; i++) {
        if (tradeHistoryData[i]['type'] == '0') {
          appendList.add(Text(
            'Bought: ${tradeHistoryData[i]['amount']} ${widget.selectedMarket.substring(0, 3)} @  ${tradeHistoryData[i]['price']} ${widget.selectedMarket.substring(3)}',
            style: kOrderBookTextStyle,
          ));
        } else {
          appendList.add(Text(
            'Sold:   ${tradeHistoryData[i]['amount']} ${widget.selectedMarket.substring(0, 3)} @  ${tradeHistoryData[i]['price']} ${widget.selectedMarket.substring(3)}',
            style: kOrderBookTextStyle,
          ));
        }
      }
      return appendList;
    } else {
      return [Text('?'), Text('?'), Text('?'), Text('?')];
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
          title: Text(
              '${widget.selectedMarket.substring(0, 3)}/${widget.selectedMarket.substring(3)}'
                      .toUpperCase() +
                  ' Trade History'),
        ),
        body: Center(
          child: CryptoDataColumn(
            childList: getTransactions(),
          ),
        ));
  }
}
