// To parse this JSON data, do
//
//     final deposit = depositFromJson(jsonString);

import 'dart:convert';

List<Deposit> depositFromJson(String str) =>
    List<Deposit>.from(json.decode(str).map((x) => Deposit.fromJson(x)));

String depositToJson(List<Deposit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Deposit {
  String model;
  int pk;
  Fields fields;

  Deposit({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
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
  DateTime date;
  String username;
  String wasteType;
  int weight;
  int poin;
  int totalPrice;

  Fields({
    required this.user,
    required this.date,
    required this.username,
    required this.wasteType,
    required this.weight,
    required this.poin,
    required this.totalPrice,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        username: json["username"],
        wasteType: json["waste_type"],
        weight: json["weight"],
        poin: json["poin"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "username": username,
        "waste_type": wasteType,
        "weight": weight,
        "poin": poin,
        "total_price": totalPrice,
      };
}
