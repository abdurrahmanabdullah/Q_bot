import 'dart:convert';

/// Model for Next and Hold tokens

List<CounterWaitingModel> counterWaitingModelFromJson(String str) =>
    List<CounterWaitingModel>.from(json.decode(str).map((x) => CounterWaitingModel.fromJson(x)));

class CounterWaitingModel {
  CounterWaitingModel({
    this.data,
  });

  List<Datum>? data;

  factory CounterWaitingModel.fromJson(Map<String, dynamic> json) => CounterWaitingModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.id,
    this.tCounterCategories,
    this.tokenId,
  });

  int? id;
  String? tCounterCategories;
  int? tokenId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tCounterCategories: json["t_counter_categories"],
        tokenId: json["token_id"],
      );
}
