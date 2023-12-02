// ignore_for_file: file_names

import 'package:cosmocycle/models/UserData.dart';
import '../models/Deposit.dart';

class UseAdminDeposit {
  Future<List<Deposit>> getAdminDeposit(request) async {
    var response = await request
        .get('https://trashsure.iyoubee.xyz/flutter/admin/deposit/get/');

    var data = response;

    List<Deposit> depositList = [];
    for (var d in data) {
      if (d != null) {
        depositList.add(Deposit.fromJson(d));
      }
    }
    return depositList;
  }

  Future<List<UserData>> getUsername(request) async {
    var response = await request
        .get('https://trashsure.iyoubee.xyz/flutter/admin/username/get/');

    var data = response;

    List<UserData> usernameList = [];
    for (var d in data) {
      if (d != null) {
        usernameList.add(UserData.fromJson(d));
      }
    }

    return usernameList;
  }

  addDeposit(context, request, username, jenisSampah, beratSampah) async {
    var response = await request.post(
        'https://trashsure.iyoubee.xyz/flutter/admin/deposit/add/', {
      "user": username,
      "jenisSampah": jenisSampah,
      "beratSampah": beratSampah
    });

    return response['status'];
  }

  accDeposit(context, pk, request) async {
    var response = await request.post(
        'https://trashsure.iyoubee.xyz/flutter/admin/deposit/acc/', {"id": pk});

    return response['status'];
  }

  delDeposit(context, pk, request) async {
    var response = await request.post(
        'https://trashsure.iyoubee.xyz/flutter/admin/deposit/del/', {"id": pk});

    return response['status'];
  }
}
