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
    subscribe();
  }

  void subscribe() {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.selectedMarket.substring(0, 3)}/${widget.selectedMarket.substring(3)}'
                      .toUpperCase() +
                  ' Live Trade'),
        ),
        body: Center(
          child: Column(
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
                        ' ${widget.selectedMarket.substring(3).toUpperCase()}';
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
                          horizontal: 20.0, vertical: 17.0),
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
