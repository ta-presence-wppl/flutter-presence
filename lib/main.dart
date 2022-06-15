//import 'dart:_http';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wppl_frontend/atasan/home_page.dart';
import 'package:wppl_frontend/boss_permission.dart';
import 'package:wppl_frontend/history.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/login_view.dart';
import 'package:wppl_frontend/salary.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/splashscreen_view.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    routes: {
      '/': (context) => SplashScreenPage(),
      '/login': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/salary': (context) => Salary(),
      '/histori': (context) => History(),
      '/pengajuan_izin': (context) => BossPermission(),
      '/pengaturan': (context) => SettingsPage(),

      //Atasan
      '/atasan/home': (context) => const HomeAtasan(),
    },
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
