import 'package:flutter/material.dart';
import 'dart:math';

class PrizeTokenPage extends StatefulWidget {
  const PrizeTokenPage({super.key});

  @override
  State<PrizeTokenPage> createState() => _PrizeTokenPageState();
}

class _PrizeTokenPageState extends State<PrizeTokenPage> {

  String randomString = '';

  @override
  void initState() {
    super.initState();
    generateRandomString();
  }

  void generateRandomString() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    randomString = List.generate(7, (index) => chars[random.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: GestureDetector(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: SizedBox(
              // App Logo in the middle of AppBar
              width: 35,
              child: Image.asset("lib/assets/bin.png")),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: Text("Your prize token:",
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
            Center(
              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: Card(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      randomString,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]
        ));
  }
}