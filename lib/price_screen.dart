import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart';
import 'dart:convert';
import 'ratess.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Future getdata() async {
    Response rep = await get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selected?apikey=CA44BE4A-EB80-4DDD-A832-36BDB4D798FB#'));
    var jsondata = rep.body;
    var data = jsonDecode(jsondata)['rate'];

    print(jsondata);
    print(rep.statusCode);
    ratesBTC = data;
    print(ratesBTC);
    return ratesBTC;
  }

  Future getdataLTC() async {
    Response rep = await get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/LTC/$selected?apikey=CA44BE4A-EB80-4DDD-A832-36BDB4D798FB#'));
    var jsondata = rep.body;
    var data = jsonDecode(jsondata)['rate'];

    print(jsondata);
    print(rep.statusCode);
    ratesLTC = data;
    print(ratesLTC);
    return ratesLTC;
  }

  Future getdataETH() async {
    Response rep = await get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/ETH/$selected?apikey=CA44BE4A-EB80-4DDD-A832-36BDB4D798FB#'));
    var jsondata = rep.body;
    var data = jsonDecode(jsondata)['rate'];

    print(jsondata);
    print(rep.statusCode);
    ratesETH = data;
    print(ratesETH);
    return ratesETH;
  }

  var ratesBTC;
  var ratesLTC;
  var ratesETH;

  String selected = 'USD';
  var index = 0;

  DropdownButton<String> androidlist() {
    List<DropdownMenuItem<String>> getitems = [];
    for (String currency in currenciesList) {
      var itemss = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      getitems.add(itemss);
    }
    return DropdownButton(
      value: selected,
      items: getitems,
      onChanged: (newvalue) {
        setState(() {
          selected = newvalue;
        });
      },
    );
  }

  CupertinoPicker iosdropdown() {
    List<Text> getpice = [];
    for (String rab in currenciesList) {
      getpice.add(Text(rab));
      print(rab);
    }
    return CupertinoPicker(
      itemExtent: 30.5,
      backgroundColor: Colors.lightBlue,
      children: getpice,
      onSelectedItemChanged: (selectedindex) {
        print(index);
        setState(() {
          selected[index];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '🤑 Coin Tracker @Rabean_subedi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
      bottomNavigationBar: Container(
        height: 150.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30.0),
        color: Colors.lightBlue,
        child: androidlist(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cards(
            text: Center(
                child: Text(
              '1 BTC=$ratesBTC $selected',
              style: TextStyle(fontSize: 20),
            )),
          ),
          cards(
            text: Center(
                child: Text(
              '1 ETH=$ratesETH $selected',
              style: TextStyle(fontSize: 20),
            )),
          ),
          cards(
            text: Center(
                child: Text(
              '1 LTC=$ratesLTC $selected',
              style: TextStyle(fontSize: 20),
            )),
          )
        ],
      ),
    );
  }
}

class cards extends StatelessWidget {
  const cards({
    Key key,
    @required this.text,
  }) : super(key: key);

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: text,
        ),
      ),
    );
  }
}

//Platform.isIOS ? iosdropdown() : androidlist(),
