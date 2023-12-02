// ignore_for_file: file_names

import 'package:cosmocycle/models/Prize.dart';

class UseAdminPrize {
  Future<List<Prize>> getAdminPrize(request) async {
    var response =
        await request.get('http://192.168.56.1:8000/api/admin/prize/get');

    var data = response;

    List<Prize> prizeList = [];
    for (var d in data) {
      if (d != null) {
        prizeList.add(Prize.fromJson(d));
      }
    }
    return prizeList;
  }

  addPrize(context, request, title, poin, stok, desc, picture) async {
    var response = await request.post(
        'http://192.168.56.1:8000/api/admin/prize/add', {
      "title": title,
      "poin": poin,
      "stok": stok,
      "desc": desc,
      "picture": picture
    });

    return response['status'];
  }

  delPrize(context, pk, request) async {
    var response = await request
        .post('http://192.168.56.1:8000/api/admin/prize/del', {"id": pk});

    return response['status'];
  }
}
