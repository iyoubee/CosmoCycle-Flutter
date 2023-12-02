// ignore_for_file: file_names

import 'package:cosmocycle/models/Prize.dart';
import 'package:cosmocycle/models/RedeemedPrize.dart';
import 'package:cosmocycle/models/UserData.dart';

class UseUserPrize {
  // To fetch prize data from admin
  Future<List<Prize>> getPrize(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/user/prize/get');

    // melakukan decode response menjadi bentuk json
    var data = response;

    // melakukan konversi data json menjadi object ToDo
    List<Prize> prizeList = [];
    for (var d in data) {
      if (d != null) {
        prizeList.add(Prize.fromJson(d));
      }
    }
    return prizeList;
  }

  // To fetch redeemed prize data from certain user
  Future<List<RedeemedPrize>> getRedeemedPrize(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/user/prize/redeem/get');

    // melakukan decode response menjadi bentuk json
    var data = response;

    // melakukan konversi data json menjadi object ToDo
    List<RedeemedPrize> prizeList = [];
    for (var d in data) {
      if (d != null) {
        prizeList.add(RedeemedPrize.fromJson(d));
      }
    }
    return prizeList;
  }

  // Method to redeem the prize
  redeemPrize(context, pk, request) async {
    var response = await request.post(
        'https://trashsure.iyoubee.xyz/flutter/user/prize/redeem/', {"id": pk});

    return response['message'];
  }

  // Method to use the prize
  usePrize(context, pk, request) async {
    var response = await request.post(
        'https://trashsure.iyoubee.xyz/flutter/user/prize/redeem/use/',
        {"id": pk});

    return response['message'];
  }

  // Method to get user points
  Future<int> getPoints(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/user/data/get');

    var data = response;

    List<UserData> balanceList = [];
    for (var d in data) {
      if (d != null) {
        balanceList.add(UserData.fromJson(d));
      }
    }

    return balanceList[0].fields.poin;
  }
}
