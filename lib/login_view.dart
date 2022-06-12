import 'dart:convert';
import 'package:wppl_frontend/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//import http package manually
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  late String errormsg;
  late bool error, showprogress;
  late String username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  void startLogin() async {
    String apiurl =
        "https://api-ta-presence-gateaway.behindrailstudio.com/auth_service/auth"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (username == '' && password == '') {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Mohon isi email dan password";
      });
    } else {
      var response = await http.post(Uri.parse(apiurl), body: {
        'email': username, //'tes@dev.com', //username, //get the username text
        'password': password, //'tes' //password //get password text
      });

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        setState(() {
          error = false;
          showprogress = false;
        });
        await prefs.setString('nama', jsondata['data']['nama']);
        await prefs.setString('email', jsondata['data']['email']);
        await prefs.setString('jabatan', jsondata['data']['kode_jabatan']);
        await prefs.setString('token', jsondata['token']);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return HomePage();
            },
          ),
        );
        //print(jsondata['token']);
        // if (jsondata["error"]) {
        //   setState(() {
        //     showprogress = false; //don't show progress indicator
        //     error = true;
        //     errormsg = jsondata["message"];
        //   });
        // } else {
        //   if (jsondata["success"]) {
        //     setState(() {
        //       error = false;
        //       showprogress = false;
        //     });
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (_){
        //         return HomePageTemp();
        //       }),
        //     );
        //   } else {
        //     showprogress = false; //don't show progress indicator
        //     error = true;
        //     errormsg = "Something went wrong.";
        //   }
        // }
      } else if (response.statusCode == 401) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Mohon Maaf Email atau Password Salah!";
        });
      } else {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Kesalahan pada server.";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('nama');
    final String? levelUser = prefs.getString('level_user');

    if (userId != null) {
      // if (levelUser == "9") {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      // } else {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (BuildContext context) => HomeKepala()));
      // }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        //make width of outer wrapper to 100%
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color(0xff85f4ff),
            ],
          ),
        ), //show linear gradient background of page

        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: const Text(
                "Silahkan Login!",
                style: TextStyle(
                  color: Color(0xff278cbd),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ABZReg',
                ),
              ), //title text
            ),
            Container(
              //show error message here
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(10),
              child: error ? errmsg(errormsg) : Container(),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _username, //set username controller
                style: const TextStyle(
                    color: Color(0xff278cbd),
                    fontSize: 20,
                    fontFamily: 'ABZReg'),
                decoration: myInputDecoration(
                  label: "Email",
                  icon: Icons.person,
                ),
                onChanged: (value) {
                  //set username  text on change
                  username = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _password, //set password controller
                style: const TextStyle(
                    color: Color(0xff278cbd),
                    fontSize: 20,
                    fontFamily: 'ABZReg'),
                obscureText: true,
                decoration: myInputDecoration(
                  label: "Password",
                  icon: Icons.lock,
                ),
                onChanged: (value) {
                  // change password text
                  password = value;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      //show progress indicator on click
                      showprogress = true;
                    });
                    startLogin();
                  },
                  child: showprogress
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff278cbd)),
                          ),
                        )
                      : const Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 25, fontFamily: 'ABZReg'),
                        ),
                  // if showprogress == true then show progress indicator
                  // else show "LOGIN NOW" text
                  colorBrightness: Brightness.dark,
                  color: Color(0xff278cbd),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                      //button corner radius
                      ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  InputDecoration myInputDecoration({String? label, IconData? icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: const TextStyle(
          color: Color(0xff278cbd), fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: const Color(0xff278cbd),
          )
          //padding and icon for prefix
          ),

      contentPadding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(
              color: Color(0xff278cbd), width: 2)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(
              color: Color(0xff278cbd), width: 2)), //focus border

      fillColor: Colors.white,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: const EdgeInsets.all(15.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 6.00),
          child: const Icon(Icons.info, color: Colors.white),
        ), // icon for error message
        Flexible(
          child: Column(
            children: [
              Text(text,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'ABZReg')),
            ],
          ),
        ),
        //show error message text
      ]),
    );
  }
}
