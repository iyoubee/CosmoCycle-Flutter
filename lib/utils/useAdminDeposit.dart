// ignore_for_file: file_names

import 'dart:convert';

import 'package:cosmocycle/models/UserData.dart';
import 'package:cosmocycle/models/Deposit.dart';

class UseAdminDeposit {
  Future<List<Deposit>> getAdminDeposit(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/admin/deposit/get');

    var data = response;

    List<Deposit> depositList = [];
    for (var d in data) {
      if (d != null) {
        depositList.add(Deposit.fromJson(d));
      }
    }
    return depositList;
  }

  Future<dynamic> getUser(context, request, token) async {
    var response = await request.post(
      'http://192.168.56.1:8000/api/admin/token',
      {"token": token},
    );

    // Assuming the backend sends a JSON response, decode it
    return response;
  }

  addDeposit(context, request, username, waste_type, weight) async {
    var response = await request.post(
        'http://192.168.56.1:8000/api/admin/deposit/add',
        {"username": username, "waste_type": waste_type, "weight": weight});

    return response['status'];
  }
}
