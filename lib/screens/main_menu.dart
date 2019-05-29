import 'package:flutter/material.dart';
import 'package:flut_stamp/constants.dart';
import 'package:flut_stamp/components/menu_item.dart';
import 'package:flut_stamp/screens/ticker_screen.dart';
import 'package:flut_stamp/screens/orderbook_screen.dart';
import 'package:flut_stamp/screens/trade_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String selectedMarket = 'btcusd';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in kStampMarkets) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedMarket,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedMarket = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in kStampMarkets) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedMarket = selectedMarket[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 70.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10.0),
            color: Colors.green,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
          MenuItemCard(
            menuText: 'Ticker Info',
            screen: TickerScreen(selectedMarket),
          ),
          MenuItemCard(
            menuText: 'Orderbook Info',
            screen: OrderBookScreen(selectedMarket),
          ),
          MenuItemCard(
            menuText: 'Trade History',
            screen: TradeHistoryScreen(selectedMarket),
          )
        ],
      ),
    );
  }
}
