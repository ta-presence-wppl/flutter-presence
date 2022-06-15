import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wppl_frontend/api/api_routes.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/history.dart';
import 'package:wppl_frontend/login_view.dart';
import 'package:wppl_frontend/salary.dart';
import 'package:wppl_frontend/boss_permission.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  int _selectedTabIndex = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ApiRoutes _apiRoutes = ApiRoutes();
  bool showPassword = true;
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void saveSettings() async {
    try {
      print(_username.text);
      _apiRoutes
          .putSettings(context, _username.text, _email.text, _password.text)
          .then(
            (value) => {
              logout(),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value!.responseMessage!),
                ),
              ),
            },
          );
    } catch (e) {
      print(e);
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );
    final _listPage = <Widget>[
      // Program untuk halaman ditulis di dalam sini
      Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4), // Border radius
                          child: ClipOval(
                              child:
                                  Image.asset("assets/images/profile-2.png")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Nama Lengkap", "", false, _username),
              buildTextField("E-mail", "", false, _email),
              buildTextField("Password", "", true, _password),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("BATAL",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ABZReg',
                            color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      saveSettings();
                    },
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "SIMPAN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg',
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff278cbd),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            fontFamily: 'ABZReg',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(child: _listPage[_selectedTabIndex]),
      //drawer: _buildDrawer(),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController contrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: contrl, //set username controller
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
