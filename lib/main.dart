import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cryptocoin/myapp_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() async {
  List currencies = await getCurrencies();
  print(currencies);

  runApp(new myApp(currencies));
}

class myApp extends StatelessWidget {
  final List currencies;
  myApp(this.currencies);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Coin',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.redAccent
              : null),
      home: HomePage(currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String cryptoUrl = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
  http.Response response = await http.get(cryptoUrl);
  return json.decode(response.body);
}
