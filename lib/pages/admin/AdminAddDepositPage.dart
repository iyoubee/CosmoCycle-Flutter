// ignore_for_file: file_names, use_build_context_synchronously, duplicate_ignore, prefer_typing_uninitialized_variables

import 'package:cosmocycle/pages/admin/AdminPage.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cosmocycle/utils/useAdminDeposit.dart';
import 'package:another_flushbar/flushbar.dart';

class AdminAddDepositPage extends StatefulWidget {
  const AdminAddDepositPage({super.key});

  @override
  State<AdminAddDepositPage> createState() => _AdminAddDepositPageState();
}

class _AdminAddDepositPageState extends State<AdminAddDepositPage> {
  UseAdminDeposit useAdminDeposit = UseAdminDeposit();

  final GlobalKey<FormState> _formKey = GlobalKey();

  String berat = "";
  var _jenis;
  var user;

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
                  child: Text(user),
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
                  child: Text(_jenis),
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
                  child: Text("$berat Kg"),
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
                        context, request, user, _jenis, berat);
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
        body: FutureBuilder(
            future: useAdminDeposit.getUsername(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.data.isNotEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "lib/assets/prize.jpg",
                          width: 50,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Belum ada user yang dapat diberikan deposit",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SingleChildScrollView(
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
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                        ),
                                        border: OutlineInputBorder()),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    items: snapshot.data
                                        .map<DropdownMenuItem<String>>((idx) {
                                      return DropdownMenuItem<String>(
                                        value: idx.fields.email,
                                        child: Text(idx.fields.email),
                                      );
                                    }).toList(),
                                    hint: const Text("Pilih User"),
                                    onChanged: (value) {
                                      setState(() {
                                        user = value;
                                        // measureList.add(measure);
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Pilih user';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        user = value;
                                      });
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                        ),
                                        border: OutlineInputBorder()),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    items: [
                                      const DropdownMenuItem(
                                        value: "Plastik",
                                        child: Text("Plastik"),
                                      ),
                                      const DropdownMenuItem(
                                        value: "Elektronik",
                                        child: Text("Elektronik"),
                                      )
                                    ],
                                    hint: const Text("Jenis Sampah"),
                                    onChanged: (value) {
                                      setState(() {
                                        _jenis = value;
                                        // measureList.add(measure);
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Pilih jenis sampah';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _jenis = value;
                                      });
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Berat total (Kg)',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                      border: OutlineInputBorder()),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value
                                            .contains(RegExp(r'^[a-zA-Z\-]'))) {
                                      return 'Use only numbers!';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      berat = value;
                                      // bodyTempList.add(bodyTemp);
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      berat = value;
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
                                  child: const Text("Submit"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}