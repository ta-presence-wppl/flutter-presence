import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wppl_frontend/home_page.dart';
import 'dart:async';

class HomePageTemp extends StatefulWidget{
  @override
  _HomePageTemp createState() => _HomePageTemp();
}

class _HomePageTemp extends State<HomePageTemp>{
  @override
  void initState() {
    super.initState();
    startSplashScreenTemp();
  }
  startSplashScreenTemp() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_){
          return HomePage();
        }),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Align(
          alignment: Alignment.center,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              Image.asset(
                "assets/images/logo2.png",
                height: 200.0,
              ),
              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Selamat\ndatang!", textAlign: TextAlign.center, style: TextStyle(
                  color:Color(0xff278cbd),fontSize: 40, fontWeight: FontWeight.bold,
                  fontFamily:'ABZReg',
                ),
                ),
              ),
            ],
          ),
        ),),
    );
  }
}