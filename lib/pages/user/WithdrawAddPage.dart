// ignore_for_file: file_names, use_build_context_synchronously, unused_local_variable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cosmocycle/pages/user/UserPage.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';
import 'package:cosmocycle/utils/useUserWithdraw.dart';

const List<String> list = <String>['E-Wallet', 'Bank Transfer'];
const List<String> wallet = <String>['OVO', 'Gopay', 'DANA', 'ShopeePay'];
const List<String> bank = <String>['BCA', "MANDIRI", 'BNI', 'BRI'];

class WithdrawAddPage extends StatefulWidget {
  const WithdrawAddPage({super.key});

  @override
  State<WithdrawAddPage> createState() => _WithdrawAddPageState();
}

class _WithdrawAddPageState extends State<WithdrawAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  UseUserWithdraw useUserWithdraw = UseUserWithdraw();

  String _amount = "";
  String _method = "e-wallet";
  String _provider_wallet = "ovo";
  String _provider_bank = 'bca';
  String _accountNo = "";
  String? validateAccountNo(String? value, String? method) {
    if (value == null || value.isEmpty) {
      return 'Account number is required';
    }

    if (method == 'bank transfer' && value.length != 9) {
      return 'Bank transfer account number must be 9 digits';
    }

    if (method == 'e-wallet' && (value.length < 9 || !value.startsWith('08'))) {
      return 'E-Wallet account number is not valid';
    }

    return null;
  }

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
                    child: Text("Jumlah:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_amount),
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Metode:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_method),
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Provider:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_method == "e-wallet"
                      ? _provider_wallet
                      : _provider_bank),
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Tujuan:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(_accountNo),
                ),
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
                    final response = await useUserWithdraw
                        .addWithdraw(
                            context,
                            request,
                            _method,
                            _method == "e-wallet"
                                ? _provider_wallet
                                : _provider_bank,
                            _accountNo,
                            _amount)
                        .then((value) => {
                              if (value['status'] == 200)
                                {
                                  Navigator.pop(context),
                                  Navigator.pop(context),
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserPage(idx: 3))),
                                  Flushbar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 29, 167, 86),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Berhasil",
                                    duration: const Duration(seconds: 3),
                                    message: value['message'],
                                  ).show(context)
                                }
                              else
                                {
                                  Navigator.pop(context),
                                  Navigator.pop(context),
                                  Flushbar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 244, 105, 77),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Gagal",
                                    duration: const Duration(seconds: 3),
                                    message: value['message'],
                                  ).show(context)
                                }
                            });
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Penarikan saldo",
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
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Jumlah',
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
                          } else if (int.parse(value) <= 0) {
                            return 'Harus lebih dari 0';
                          } else if (int.parse(value) < 25000) {
                            return 'Minimum 25000';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            _amount = value;
                            // bodyTempList.add(bodyTemp);
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _amount = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: _method,
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
                            _method = value!;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Dropdown for Provider (dependent on Method)
                      if (_method == 'e-wallet')
                        DropdownButtonFormField<String>(
                          value: _provider_wallet,
                          decoration: const InputDecoration(
                            labelText: 'Provider',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items: wallet
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toLowerCase(),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _provider_wallet = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a provider';
                            }
                            return null;
                          },
                        )
                      else if (_method == 'bank transfer')
                        DropdownButtonFormField<String>(
                          value: _provider_bank,
                          decoration: const InputDecoration(
                            labelText: 'Provider',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items: bank
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toLowerCase(),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _provider_bank = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a provider';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(
                        height: 20,
                      ), // TextFormField for Account Number
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'No.Rek atau No.Tlp',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => validateAccountNo(value, _method),
                        onFieldSubmitted: (value) {
                          setState(() {
                            _accountNo = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _accountNo = value;
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
