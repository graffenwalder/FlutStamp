import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> kStampMarkets = [
  'btcusd',
  'btceur',
  'eurusd',
  'xrpusd',
  'xrpeur',
  'xrpbtc',
  'ltcusd',
  'ltceur',
  'ltcbtc',
  'ethusd',
  'etheur',
  'ethbtc',
  'bchusd',
  'bcheur',
  'bchbtc'
];

const bitstampBaseURL = 'https://www.bitstamp.net/api/v2/';

class MarketData {
  MarketData();
  Future getMarketData(String marketType, String market) async {
    String requestURL = '$bitstampBaseURL/$marketType/$market';

    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var marketData = jsonDecode(response.body);
      return marketData;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
