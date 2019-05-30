import 'package:flutter/material.dart';
import 'package:FlutStamp/market_data.dart';
import 'package:FlutStamp/components/menu_item.dart';
import 'package:FlutStamp/screens/orderbook_screen.dart';
import 'package:FlutStamp/screens/trade_history_screen.dart';
import 'package:FlutStamp/constants.dart';

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(vertical: 17.0),
              decoration: BoxDecoration(
                color: Color(0xff00b347),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    '${widget.selectedMarket.substring(0, 3)}/${widget.selectedMarket.substring(3)}'
                        .toUpperCase(),
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    marketInfo.containsKey('last')
                        ? marketInfo['last'] +
                            ' ' +
                            widget.selectedMarket.substring(3).toUpperCase()
                        : 'Waiting for Market Info',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        marketInfo.containsKey('last')
                            ? (double.parse(marketInfo['open']) -
                                        double.parse(marketInfo['last']))
                                    .toStringAsFixed(2) +
                                ' ' +
                                widget.selectedMarket.substring(3).toUpperCase()
                            : '?',
                        style: kTickerChangeTextStyle,
                      ),
                      Text(
                        marketInfo.containsKey('last')
                            ? ((double.parse(marketInfo['open']) -
                                            double.parse(marketInfo['last'])) /
                                        double.parse(marketInfo['open']))
                                    .toStringAsFixed(2) +
                                ' %'
                            : '?',
                        style: kTickerChangeTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            marketInfo.containsKey('high')
                                ? 'High: ' + marketInfo['high']
                                : '?',
                            style: kTickerChangeTextStyle,
                          ),
                          Text(
                            marketInfo.containsKey('bid')
                                ? 'Bid: ' + marketInfo['bid']
                                : '?',
                            style: kTickerChangeTextStyle,
                          ),
                          Text(
                            marketInfo.containsKey('vwap')
                                ? 'VWAP: ' + marketInfo['vwap']
                                : '?',
                            style: kTickerChangeTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            marketInfo.containsKey('low')
                                ? 'Low: ' + marketInfo['low']
                                : '?',
                            style: kTickerChangeTextStyle,
                          ),
                          Text(
                            marketInfo.containsKey('ask')
                                ? 'Ask: ' + marketInfo['ask']
                                : '?',
                            style: kTickerChangeTextStyle,
                          ),
                          Text(
                            marketInfo.containsKey('volume')
                                ? 'Volume: ' +
                                    double.parse(marketInfo['volume'])
                                        .toStringAsFixed(2)
                                : '?',
                            style: kTickerChangeTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
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
