import 'package:flutter/material.dart';
import 'package:flut_stamp/constants.dart';

class TickerTextWidget extends StatelessWidget {
  TickerTextWidget(
      {@required this.marketInfoMap,
      @required this.marketMapKey,
      @required this.preText});

  final Map marketInfoMap;
  final String marketMapKey;
  final String preText;

  @override
  Widget build(BuildContext context) {
    return Text(
      marketInfoMap.containsKey(marketMapKey)
          ? preText + marketInfoMap[marketMapKey]
          : '?',
      style: kTickerChangeTextStyle,
    );
  }
}
