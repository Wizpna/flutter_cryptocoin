import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 1.0,
        title: new Text('Crypto Coin'),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.blueGrey.shade700,
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencies[index];
              final MaterialColor color = _colors[index % _colors.length];
              return getListItemUi(currency, color);
            },
            itemCount: widget.currencies.length,
          )),
        ],
      ),
    );
  }

  Widget getListItemUi(Map currency, MaterialColor color) {
    return Container(
      height: 130,
      child: Card(
        elevation: 15.0,
        color: Colors.blueGrey.shade600,
        child: new ListTile(
          leading: new CircleAvatar(
            backgroundColor: color,
            child: new Text(
              currency['name'][0],
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          title: new Text(
            currency['name'],
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  getSubtitleText1(
                    currency['price_usd'],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    getSubtitleText2(
                      currency['percent_change_1h'],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  getSubtitleText3(
                    currency['percent_change_24h'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSubtitleText(
    String priceUSD,
  ) {
    TextSpan priceTextWidget = new TextSpan(
        text: '\$$priceUSD\n',
        style: new TextStyle(color: Colors.black, fontSize: 16.0));

    return new RichText(
        text: new TextSpan(children: [
      priceTextWidget,
    ]));
  }
}

Widget getSubtitleText1(
  String priceUSD,
) {
  TextSpan priceTextWidget = new TextSpan(
      text: '\$$priceUSD\n',
      style: new TextStyle(color: Colors.black, fontSize: 16.0));

  return new RichText(
      text: new TextSpan(children: [
    const TextSpan(
      text: '\n',
    ),
    priceTextWidget,
  ]));
}

Widget getSubtitleText2(
  String percentageChange,
) {
  String percentageChangeText = '1 hour: $percentageChange%';
  TextSpan percentageChangeTextWidget;

  if (double.parse(percentageChange) > 0) {
    percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText, style: new TextStyle(color: Colors.green));
  } else {
    percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText, style: new TextStyle(color: Colors.red));
  }

  return new RichText(
      text: new TextSpan(children: [
    percentageChangeTextWidget,
  ]));
}

Widget getSubtitleText3(
  String percentageChange24,
) {
  String percentageChangeText24 = '24 hour: $percentageChange24%';
  TextSpan percentageChangeTextWidget24;

  if (double.parse(percentageChange24) > 0) {
    percentageChangeTextWidget24 = new TextSpan(
        text: percentageChangeText24,
        style: new TextStyle(color: Colors.green));
  } else {
    percentageChangeTextWidget24 = new TextSpan(
        text: percentageChangeText24, style: new TextStyle(color: Colors.red));
  }
  return new RichText(
      text: new TextSpan(children: [percentageChangeTextWidget24]));
}
