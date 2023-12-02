// ignore_for_file: file_names, use_build_context_synchronously, duplicate_ignore, prefer_typing_uninitialized_variables

import 'package:cosmocycle/pages/admin/AdminPage.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cosmocycle/utils/useAdminDeposit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';

const List<String> list = <String>['Plastic', 'Paper', 'Glass', "Metal"];

class AdminAddDepositPage extends StatefulWidget {
  const AdminAddDepositPage({super.key});

  @override
  State<AdminAddDepositPage> createState() => _AdminAddDepositPageState();
}

class _AdminAddDepositPageState extends State<AdminAddDepositPage> {
  UseAdminDeposit useAdminDeposit = UseAdminDeposit();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formKeyToken = GlobalKey();

  String _token = "";
  String _username = "";
  int _id = -1;
  String _weight = "";
  String _waste_type = "plastic";
  bool _enabledText = true;
  bool _disabledButton = false;

  void _submit(context, request) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("User:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_username),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Jenis sampah:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_waste_type),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Berat total:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("$_weight Kg"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Batal'),
                  onPressed: () {
                    Navigator.pop(context);
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Konfirmasi'),
                  onPressed: () async {
                    int response = await useAdminDeposit.addDeposit(
                        context, request, _username, _waste_type, _weight);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPage(idx: 1)),
                        (route) => false);
                    if (response == 200) {
                      Flushbar(
                        backgroundColor: const Color.fromARGB(255, 29, 167, 86),
                        flushbarPosition: FlushbarPosition.TOP,
                        title: "Berhasil",
                        duration: const Duration(seconds: 3),
                        message: "Deposit berhasil dibuat",
                      ).show(context);
                    } else {
                      Flushbar(
                        backgroundColor:
                            const Color.fromARGB(255, 244, 105, 77),
                        flushbarPosition: FlushbarPosition.TOP,
                        title: "Gagal",
                        duration: const Duration(seconds: 3),
                        message: "Ada yang salah",
                      ).show(context);
                    }
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset();
                    setState(() {});
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void _search(context, request) async {
    try {
      var response = await useAdminDeposit.getUser(context, request, _token);
      // Assuming the response contains 'id' and 'username' fields
      int userId = response['id'];
      String username = response['username'];

      setState(() {
        _id = userId;
        _username = username;
        _enabledText = false;
        _disabledButton = true;
      });

      Flushbar(
        backgroundColor: const Color.fromARGB(255, 29, 167, 86),
        flushbarPosition: FlushbarPosition.TOP,
        title: "Berhasil",
        duration: const Duration(seconds: 3),
        message: "User ditemukan",
      ).show(context);
    } catch (error) {
      // Handle errors, if any
      setState(() {
        _id = -1;
        _username = "";
      });
      Flushbar(
        backgroundColor: const Color.fromARGB(255, 244, 105, 77),
        flushbarPosition: FlushbarPosition.TOP,
        title: "Gagal",
        duration: const Duration(seconds: 3),
        message: "Not Found",
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: <Widget>[
            GestureDetector(
              child: IconButton(
                icon: const Icon(
                  Icons.autorenew,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Masukan Data Deposit",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKeyToken,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Token User',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else if (value.length != 6 ||
                              !RegExp(r'^[A-Z]{6}$').hasMatch(value)) {
                            return 'Please enter exactly 6 uppercase letters';
                          }
                          return null;
                        },
                        enabled: _enabledText,
                        onFieldSubmitted: (value) {
                          setState(() {
                            _token = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _token = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 5, 89, 91),
                            minimumSize: const Size.fromHeight(60)),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKeyToken.currentState!.validate() &&
                              !_disabledButton) {
                            _search(context, request);
                          }
                        },
                        child: const Text("Cari",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          enabled: false,
                          labelText: 'Username',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: _username == '' ? 'Not Found' : _username),
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: _waste_type,
                        decoration: const InputDecoration(
                          labelText: 'Method',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toLowerCase(),
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _waste_type = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Berat total (Kg)',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Use only numbers!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            _weight = value;
                            // bodyTempList.add(bodyTemp);
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _weight = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 5, 89, 91),
                            minimumSize: const Size.fromHeight(60)),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _submit(context, request);
                          }
                        },
                        child: const Text("Submit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
