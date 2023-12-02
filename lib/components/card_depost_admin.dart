// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cosmocycle/utils/useAdminDeposit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cosmocycle/utils/auth.dart';

class CardDepositAdmin extends StatelessWidget {
  const CardDepositAdmin({
    super.key,
    required this.pk,
    required this.username,
    required this.date,
    required this.wasteType,
    required this.weight,
  });

  final String pk;
  final String username;
  final DateTime date;
  final String wasteType;
  final String weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            // leading: Image.asset(
            //   wasteType == 'Plastik'
            //       ? "lib/assets/plastic.png"
            //       : "lib/assets/electronic.png",
            //   height: 40,
            //   width: 40,
            // ),
            title: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    wasteType,
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
