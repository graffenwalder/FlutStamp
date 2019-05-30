import 'package:flutter/material.dart';
import 'package:flut_stamp/market_data.dart';
import 'package:flut_stamp/components/menu_item.dart';
import 'package:flut_stamp/screens/ticker_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flut_stamp/constants.dart';
import 'dart:io' show Platform;

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String selectedMarket = 'btcusd';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String market in kStampMarkets) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(
              '${market.substring(0, 3)}/${market.substring(3)}'.toUpperCase()),
          value: market,
        ),
      );
    }

    return DropdownButton<String>(
      style: kMenuTextStyle,
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
    for (String market in kStampMarkets) {
      pickerItems.add(
        Text(
          '${market.substring(0, 3)}/${market.substring(3)}'.toUpperCase(),
          style: kMenuTextStyle,
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: Color(0xff00cf5e),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedMarket = kStampMarkets[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutStamp'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text('Select Market:', style: kMenuInBetweenTextStyle),
            ),
          ),
          Container(
            height: 60.0,
            child: Center(
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 7.0),
            decoration: BoxDecoration(
              color: Color(0xff00cf5e),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(
            height: 280.0,
          ),
          MenuItemCard(
            menuText: 'Get Market Info',
            screen: TickerScreen(selectedMarket),
          ),
        ],
      ),
    );
  }
}
