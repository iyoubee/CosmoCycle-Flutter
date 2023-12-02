// ignore_for_file: file_names

import 'package:cosmocycle/models/UserData.dart';
import 'package:cosmocycle/models/Withdraw.dart';

class UseUserWithdraw {
  Future<List<Withdraw>> getWithdraw(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/user/withdraw/get');

    var data = response;

    List<Withdraw> withdrawList = [];
    for (var d in data) {
      if (d != null) {
        withdrawList.add(Withdraw.fromJson(d));
      }
    }
    return withdrawList;
  }

  Future<List<UserData>> getBalance(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/user/data/get');

    var data = response;

    List<UserData> balanceList = [];
    for (var d in data) {
      if (d != null) {
        balanceList.add(UserData.fromJson(d));
      }
    }

    return balanceList;
  }

  Future<dynamic> addWithdraw(
      context, request, method, provider, account_no, amount) async {
    var response =
        await request.post('http://192.168.56.1:8000/api/user/withdraw/add', {
      "method": method,
      "provider": provider,
      "account_no": account_no,
      "amount": amount,
    });

    return response;
  }
}
