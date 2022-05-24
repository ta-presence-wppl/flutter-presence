import 'dart:convert';
import 'package:wppl_frontend/home_page_temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//import http package manually
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{
  late String errormsg;
  late bool error, showprogress;
  late String username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "http://192.168.10.87/wppl_backend/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    var response = await http.post(Uri.parse(apiurl), body: {
      'username': username, //get the username text
      'password': password  //get password text
    });
    try{
      var jsonobj = jsonDecode(apiurl);
    }catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      if(jsondata["error"]){
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      }else{
        if(jsondata["success"]){
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_){
              return HomePageTemp();
            }),
          );
          //user shared preference to save data
        }else{
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      //color set to transperent or set your own color
    ));
    return Scaffold(
      body: SingleChildScrollView(
          child:Container(
            constraints: BoxConstraints(
                minHeight:MediaQuery.of(context).size.height
              //set minimum height equal to 100% of VH
            ),
            width:MediaQuery.of(context).size.width,
            //make width of outer wrapper to 100%
            decoration:BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ Colors.white,
                          Colors.white,Colors.white,Colors.white,Color(0xff85f4ff),
                ],
              ),
            ), //show linear gradient background of page

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[
              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Silahkan Login!", style: TextStyle(
                    color:Color(0xff278cbd),fontSize: 40, fontWeight: FontWeight.bold, fontFamily:'ABZReg',
                ),), //title text
              ),
              Container(
                //show error message here
                margin: EdgeInsets.only(top:30),
                padding: EdgeInsets.all(10),
                child:error? errmsg(errormsg):Container(),
                //if error == true then show error message
                //else set empty container as child
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextField(
                  controller: _username, //set username controller
                  style:TextStyle(color:Color(0xff278cbd), fontSize:20, fontFamily:'ABZReg'),
                  decoration: myInputDecoration(
                    label: "Username",
                    icon: Icons.person,
                  ),
                  onChanged: (value){
                    //set username  text on change
                    username = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _password, //set password controller
                  style: TextStyle(color:Color(0xff278cbd), fontSize:20, fontFamily:'ABZReg'),
                  obscureText: true,
                  decoration: myInputDecoration(
                    label: "Password",
                    icon: Icons.lock,
                  ),
                  onChanged: (value){
                    // change password text
                    password = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: SizedBox(
                  height: 60, width: double.infinity,
                  child:RaisedButton(
                    onPressed: (){
                      setState(() {
                        //show progress indicator on click
                        showprogress = true;
                      });
                      startLogin();
                    },
                    child: showprogress?
                    SizedBox(
                      height:30, width:30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xff278cbd)),
                      ),
                    ):Text("LOGIN", style: TextStyle(fontSize: 25, fontFamily:'ABZReg'),),
                    // if showprogress == true then show progress indicator
                    // else show "LOGIN NOW" text
                    colorBrightness: Brightness.dark,
                    color: Color(0xff278cbd),
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30)
                      //button corner radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  InputDecoration myInputDecoration({String? label, IconData? icon}){
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color:Color(0xff278cbd), fontSize:20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Color(0xff278cbd),)
        //padding and icon for prefix
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
      ), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
      ), //focus border

      fillColor: Colors.white,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text){
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color:Colors.red, width:2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18, fontFamily:'ABZReg')),
        //show error message text
      ]),
    );
  }
}