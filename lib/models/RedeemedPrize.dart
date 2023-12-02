// To parse this JSON data, do
//
//     final redeemedPrize = redeemedPrizeFromJson(jsonString);

import 'dart:convert';

List<RedeemedPrize> redeemedPrizeFromJson(String str) =>
    List<RedeemedPrize>.from(
        json.decode(str).map((x) => RedeemedPrize.fromJson(x)));

String redeemedPrizeToJson(List<RedeemedPrize> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RedeemedPrize {
  String model;
  int pk;
  Fields fields;

  RedeemedPrize({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory RedeemedPrize.fromJson(Map<String, dynamic> json) => RedeemedPrize(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  int stok;
  String title;
  String desc;

  Fields({
    required this.user,
    required this.stok,
    required this.title,
    required this.desc,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        stok: json["stok"],
        title: json["title"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "stok": stok,
        "title": title,
        "desc": desc,
      };
}
