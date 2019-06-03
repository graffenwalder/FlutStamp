import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';
import 'package:flut_stamp/components/menu_item.dart';
import 'package:flut_stamp/screens/orderbook_screen.dart';
import 'package:flut_stamp/screens/trade_history_screen.dart';
import 'package:flut_stamp/constants.dart';
import 'package:flut_stamp/components/ticker_text_widget.dart';

class TickerScreen extends StatefulWidget {
  TickerScreen(this.selectedMarket);
  final String selectedMarket;
  @override
  _TickerScreenState createState() => _TickerScreenState();
}

class _TickerScreenState extends State<TickerScreen> {
  Map marketInfoMap = {};

  void getData() async {
    try {
      Map rawData =
          await MarketData().getMarketData('ticker', widget.selectedMarket);
      setState(() {
        marketInfoMap = rawData;
      });
    } catch (e) {
      print(e);
    }
  }

  bool marketIsBTC() {
    if (widget.selectedMarket.substring(3) == 'btc') {
      return true;
    }
    return false;
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
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    marketInfoMap.containsKey('last')
                        ? marketInfoMap['last'] +
                            ' ' +
                            widget.selectedMarket.substring(3).toUpperCase()
                        : 'Getting info...',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TickerTextWidget(
                    marketInfoMap: marketInfoMap,
                    marketMapKey: 'open',
                    preText: 'Open: ',
                    decimalPoints: marketIsBTC() ? 6 : 2,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        marketInfoMap.containsKey('last')
                            ? (double.parse(marketInfoMap['last']) -
                                        double.parse(marketInfoMap['open']))
                                    .toStringAsFixed(marketIsBTC() ? 6 : 2) +
                                ' ' +
                                widget.selectedMarket.substring(3).toUpperCase()
                            : '?',
                        style: kTickerChangeTextStyle,
                      ),
                      Text(
                        marketInfoMap.containsKey('last')
                            ? ((double.parse(marketInfoMap['last']) -
                                            double.parse(
                                                marketInfoMap['open'])) /
                                        double.parse(marketInfoMap['open']) *
                                        100)
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
                          TickerTextWidget(
                            marketInfoMap: marketInfoMap,
                            marketMapKey: 'high',
                            preText: 'High: ',
                            decimalPoints: marketIsBTC() ? 6 : 2,
                          ),
                          TickerTextWidget(
                            marketInfoMap: marketInfoMap,
                            marketMapKey: 'bid',
                            preText: 'Bid: ',
                            decimalPoints: marketIsBTC() ? 6 : 2,
                          ),
                          TickerTextWidget(
                            marketInfoMap: marketInfoMap,
                            marketMapKey: 'vwap',
                            preText: 'VWAP: ',
                            decimalPoints: marketIsBTC() ? 6 : 2,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TickerTextWidget(
                            marketInfoMap: marketInfoMap,
                            marketMapKey: 'low',
                            preText: 'Low: ',
                            decimalPoints: marketIsBTC() ? 6 : 2,
                          ),
                          TickerTextWidget(
                            marketInfoMap: marketInfoMap,
                            marketMapKey: 'ask',
                            preText: 'Ask: ',
                            decimalPoints: marketIsBTC() ? 6 : 2,
                          ),
                          TickerTextWidget(
                              marketInfoMap: marketInfoMap,
                              marketMapKey: 'volume',
                              preText: 'Volume: ',
                              decimalPoints: 2),
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
