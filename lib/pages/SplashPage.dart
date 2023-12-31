// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cosmocycle/pages/admin/AdminPage.dart';
import 'package:cosmocycle/utils/useRole.dart';
import 'package:flutter/material.dart';
import 'package:cosmocycle/pages/LandingPage.dart';
import 'package:cosmocycle/pages/user/UserPage.dart';
import 'package:cosmocycle/utils/auth.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoggedInAndNavigate();
  }

  void _checkLoggedInAndNavigate() async {
    final request = context.read<CookieRequest>();

    await request.init();
    if (request.loggedIn) {
      UseRole useRole = UseRole();
      try {
        final roleResponse = await useRole.getRole(request);

        if (roleResponse.containsKey("isUser") &&
            roleResponse["isUser"] == "true") {
          // Check the role and navigate accordingly
          String role = roleResponse["role"];
          if (role == "user") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserPage(idx: 1)),
            );
          } else if (role == "admin") {
            // Handle admin role
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminPage(idx: 1)),
            );
          }
        } else {
          // Handle invalid response
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        }
      } catch (error) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      }
    } else {
      // Add a 3-second delay // Add a small delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    }
  }

  bool loadingBallAppear = false;
  double loadingBallSize = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 0, end: loadingBallSize),
                    onEnd: () {
                      setState(() {
                        if (loadingBallSize == 1) {
                          loadingBallSize = 1.5;
                        } else {
                          loadingBallSize = 1;
                        }
                      });
                    },
                    builder: (_, value, __) => Transform.scale(
                      scale: value,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: null),
                    ),
                  ),
                ),
              ],
            )));
  }
}
