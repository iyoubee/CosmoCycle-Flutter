// ignore_for_file: file_names

import 'package:cosmocycle/models/Deposit.dart';

class UseUserDeposit {
  Future<List<Deposit>> getUserDeposit(request) async {
    var response = await request
        .get('https://web-production-276d.up.railway.app/api/user/deposit/get');

    var data = response;

    List<Deposit> depositList = [];
    for (var d in data) {
      if (d != null) {
        depositList.add(Deposit.fromJson(d));
      }
    }
    return depositList;
  }

  getToken(request) async {
    var response = await request
        .get('https://web-production-276d.up.railway.app/api/user/token');

    return response;
  }
}
