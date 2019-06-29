import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradeStream extends StatefulWidget {
  TradeStream(this.selectedMarket);

  final String selectedMarket;

  @override
  _TradeStreamState createState() => _TradeStreamState();
}

class _TradeStreamState extends State<TradeStream> {
  WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('wss://ws.bitstamp.net');
    channel.sink.add(jsonEncode({
      "event": "bts:subscribe",
      "data": {"channel": "live_trades_${widget.selectedMarket}"}
    }));
  }

  @override
  void dispose() {
    channel.sink.add(jsonEncode({
      "event": "bts:unsubscribe",
      "data": {"channel": "live_trades_${widget.selectedMarket}"}
    }));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String _crypto = widget.selectedMarket.substring(0, 3);
    final String _market = widget.selectedMarket.substring(3);
    return Scaffold(
        appBar: AppBar(
          title: Text('$_crypto/$_market'.toUpperCase() + ' Live Trade'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: channel.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  String text = '';

                  bool hasPriceData() {
                    if (jsonDecode(snapshot.data)['data']['price_str'] !=
                        null) {
                      return true;
                    }
                    return false;
                  }

                  if (!snapshot.hasData) {
                    text = 'No data...';
                  } else if (hasPriceData()) {
                    text = jsonDecode(snapshot.data)['data']['price_str'] +
                        ' ' +
                        _market.toUpperCase();
                  } else {
                    text = 'No trades yet...';
                  }

                  return Container(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w900),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: Color(0xff00b347),
                        borderRadius: BorderRadius.circular(10.0),
                      ));
                },
              )
            ],
          ),
        ));
  }
}
