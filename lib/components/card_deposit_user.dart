// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDepositUser extends StatelessWidget {
  const CardDepositUser({
    super.key,
    required this.pk,
    required this.username,
    required this.date,
    required this.wasteType,
    required this.weight,
    required this.totalPrice,
    required this.poin,
  });

  final String pk;
  final String username;
  final DateTime date;
  final String wasteType;
  final String weight;
  final String totalPrice;
  final String poin;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            leading: Image.asset(
              wasteType == 'plastic'
                  ? "lib/assets/plastic.png"
                  : wasteType == 'glass'
                      ? "lib/assets/glass.png"
                      : wasteType == 'paper'
                          ? "lib/assets/paper.png"
                          : "lib/assets/crucible.png",
              height: 40,
              width: 40,
            ),
            title: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wasteType.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Poin: $poin",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    "Saldo: $totalPrice",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$weight kg",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  DateFormat.yMMMd().format(date),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
