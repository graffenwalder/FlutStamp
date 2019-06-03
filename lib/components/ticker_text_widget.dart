import 'package:flutter/material.dart';
import 'package:flut_stamp/constants.dart';

class TickerTextWidget extends StatelessWidget {
  TickerTextWidget(
      {@required this.marketInfoMap,
      @required this.marketMapKey,
      @required this.preText,
      @required this.decimalPoints});

  final Map marketInfoMap;
  final String marketMapKey;
  final String preText;
  final int decimalPoints;

  @override
  Widget build(BuildContext context) {
    return Text(
      marketInfoMap.containsKey(marketMapKey)
          ? preText +
              (double.parse(marketInfoMap[marketMapKey])
                  .toStringAsFixed(decimalPoints))
          : '?',
      style: kTickerChangeTextStyle,
    );
  }
}
