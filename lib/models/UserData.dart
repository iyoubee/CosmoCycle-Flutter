// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  String model;
  int pk;
  Fields fields;

  UserData({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
  String username;
  String token;
  int poin;
  int balance;

  Fields({
    required this.user,
    required this.username,
    required this.token,
    required this.poin,
    required this.balance,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        token: json["token"],
        poin: json["poin"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "token": token,
        "poin": poin,
        "balance": balance,
      };
}
