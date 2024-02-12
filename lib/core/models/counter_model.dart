import 'dart:convert';

/// Model for current serving tokens

List<CounterModel> counterModelFromJson(String str) => List<CounterModel>.from(json.decode(str).map((x) => CounterModel.fromJson(x)));

class CounterModel {
  CounterModel({
    this.counter,
    this.tokenId,
  });

  int? counter;
  int? tokenId;

  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
        counter: json["counter"],
        tokenId: json["token_id"],
      );
}
