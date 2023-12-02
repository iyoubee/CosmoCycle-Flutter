// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cosmocycle/components/card_deposit_user.dart';
import 'package:cosmocycle/utils/useUserDeposit.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  UseUserDeposit useUserDeposit = UseUserDeposit();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
          child: Column(
            children: [
              const Text(
                "Deposit",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: useUserDeposit.getToken(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Error fetching data');
                  } else if (snapshot.data == null || !(snapshot.data is Map)) {
                    return const Center(
                      child: Text('Token tidak ditemukan'),
                    );
                  } else {
                    final token = snapshot.data['token'];

                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Token:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            token.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "History",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: useUserDeposit.getUserDeposit(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.data.isNotEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/depo.jpg",
                              width: 50,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Belum ada deposit",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => CardDepositUser(
                                date: snapshot.data![index].fields.date,
                                totalHarga: snapshot
                                    .data![index].fields.totalHarga
                                    .toString(),
                                beratSampah: snapshot
                                    .data![index].fields.beratSampah
                                    .toString(),
                                jenisSampah:
                                    snapshot.data![index].fields.jenisSampah,
                                poin: snapshot.data![index].fields.poin
                                    .toString(),
                                isApprove:
                                    snapshot.data![index].fields.isApprove,
                              ));
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
