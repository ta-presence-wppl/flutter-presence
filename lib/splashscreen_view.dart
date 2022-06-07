import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/login_view.dart';
import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 2);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('nama');
    final String? levelUser = prefs.getString('level_user');

    if (userId != null) {
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return HomePage();
          }),
        );
      });
    } else {
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return LoginPage();
          }),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 1080.0,
          height: 1920.0,
        ),
      ),
    );
  }
}
