import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';
import 'package:flut_stamp/constants.dart';
import 'package:flut_stamp/components/data_column.dart';

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

  List<Text> getOrderBook(String orderType) {
    if (orderBookData.containsKey('bids')) {
      List<Text> appendList = [];
      int ordersPerContainer = 10;
      if (orderBookData.length < ordersPerContainer) {
        ordersPerContainer = orderBookData.length;
      }
      for (int i = 0; i < ordersPerContainer; i++) {
        appendList.add(
          Text(
            '${orderBookData[orderType][i][1]} ${widget.selectedMarket.substring(0, 3)} @ ${orderBookData[orderType][i][0]} ${widget.selectedMarket.substring(3)}',
            style: kOrderBookTextStyle,
          ),
        );
      }
      return appendList;
    } else {
      return [
        Text('????? @ ?????'),
        Text('????? @ ?????'),
        Text('????? @ ?????'),
        Text('????? @ ?????')
      ];
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
                  ' Order Book'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Bids',
                style: kMenuInBetweenTextStyle,
              ),
              CryptoDataColumn(
                childList: getOrderBook('bids'),
              ),
              Text(
                'Asks',
                style: kMenuInBetweenTextStyle,
              ),
              CryptoDataColumn(
                childList: getOrderBook('asks'),
              )
            ],
          ),
        ));
  }
}
