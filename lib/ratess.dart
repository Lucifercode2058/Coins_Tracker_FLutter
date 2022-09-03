import 'dart:convert';

import 'package:http/http.dart';
import 'package:bitcoin_ticker/price_screen.dart';


class Rate{
  double rate;
  String url;

  Rate(this.url);

  Future getrate()async{
    Response rep= await get(Uri.parse(url));
    var jsondata=rep.body;
    var data=jsonDecode(jsondata)['rate'];
    data=rate;
    return data;
  }


}
