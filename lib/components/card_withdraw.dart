import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWithdraw extends StatelessWidget {
  const CardWithdraw({
    super.key,
    required this.date,
    required this.jumlah,
    required this.metode,
    required this.accountNo,
  });

  final DateTime date;
  final String jumlah;
  final String metode;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      alignment: Alignment.topLeft,
      child: Card(
        child: ListTile(
          leading: Image.asset(
            "lib/assets/withdraw.png",
            height: 30,
            width: 30,
          ),
          title: Text(DateFormat.yMMMd().format(date)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(metode.toUpperCase()), Text(accountNo)],
          ),
          trailing: Text(
            "Rp $jumlah",
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
