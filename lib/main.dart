import 'package:flutter/material.dart';
import 'package:cosmocycle/pages/SplashPage.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';
import 'package:cosmocycle/pages/LandingPage.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'CosmoCylce',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: "/splash",
        routes: {
          "/splash": (BuildContext context) => const SplashPage(),
          "/landing": (BuildContext context) => const LandingPage(),
          "/login": (BuildContext context) => const LoginPage(),
          "/register": (BuildContext context) => const RegisterPage(),
        },
      ),
    );
  }
}
