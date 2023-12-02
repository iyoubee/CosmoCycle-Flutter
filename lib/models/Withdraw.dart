// To parse this JSON data, do
//
//     final withdraw = withdrawFromJson(jsonString);

import 'dart:convert';

List<Withdraw> withdrawFromJson(String str) =>
    List<Withdraw>.from(json.decode(str).map((x) => Withdraw.fromJson(x)));

String withdrawToJson(List<Withdraw> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Withdraw {
  String model;
  int pk;
  Fields fields;

  Withdraw({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
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
  String method;
  String provider;
  String accountNo;
  int amount;

  Fields({
    required this.user,
    required this.date,
    required this.method,
    required this.provider,
    required this.accountNo,
    required this.amount,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        method: json["method"],
        provider: json["provider"],
        accountNo: json["account_no"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "method": method,
        "provider": provider,
        "account_no": accountNo,
        "amount": amount,
      };
}
