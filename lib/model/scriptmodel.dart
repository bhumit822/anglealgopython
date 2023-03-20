// To parse this JSON data, do
//
//     final todaysOrderModel = todaysOrderModelFromJson(jsonString);

import 'dart:convert';

List<ScriptModel> scriptListModelFromJson(String str) => List<ScriptModel>.from(
    json.decode(str).map((x) => ScriptModel.fromJson(x)));

String scriptListModelToJson(List<ScriptModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScriptModel {
  ScriptModel({
    this.token,
    this.symbol,
    this.name,
    this.expiry,
    this.strike,
    this.lotsize,
    this.instrumenttype,
    this.exchSeg,
    this.tickSize,
  });

  String? token;
  String? symbol;
  String? name;
  String? expiry;
  String? strike;
  String? lotsize;
  String? instrumenttype;
  String? exchSeg;
  String? tickSize;

  ScriptModel copyWith({
    String? token,
    String? symbol,
    String? name,
    String? expiry,
    String? strike,
    String? lotsize,
    String? instrumenttype,
    String? exchSeg,
    String? tickSize,
  }) =>
      ScriptModel(
        token: token ?? this.token,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        expiry: expiry ?? this.expiry,
        strike: strike ?? this.strike,
        lotsize: lotsize ?? this.lotsize,
        instrumenttype: instrumenttype ?? this.instrumenttype,
        exchSeg: exchSeg ?? this.exchSeg,
        tickSize: tickSize ?? this.tickSize,
      );

  factory ScriptModel.fromJson(Map<String, dynamic> json) => ScriptModel(
        token: json["token"],
        symbol: json["symbol"],
        name: json["name"],
        expiry: json["expiry"],
        strike: json["strike"],
        lotsize: json["lotsize"],
        instrumenttype: json["instrumenttype"],
        exchSeg: json["exch_seg"],
        tickSize: json["tick_size"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "symbol": symbol,
        "name": name,
        "expiry": expiry,
        "strike": strike,
        "lotsize": lotsize,
        "instrumenttype": instrumenttype,
        "exch_seg": exchSeg,
        "tick_size": tickSize,
      };
}
