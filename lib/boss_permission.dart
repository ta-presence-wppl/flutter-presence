import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/history.dart';
import 'package:wppl_frontend/salary.dart';
import 'package:intl/intl.dart';

class BossPermission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BossPermissionState();
  }
}

class BossPermissionState extends State<BossPermission> {
  String? _valPerm;
  List _listPerm = [
    "Sakit",
    "Izin",
  ];
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  TextEditingController alasanController = TextEditingController();
  String alasan = '';
  bool showPassword = false;
  int _selectedTabIndex = 0;
  @override
  void initState() {
    dateinputStart.text = "";
    dateinputEnd.text = "";//set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),);
    final _listPage = <Widget>[
      Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 310,
                      height: 130,
                      child: Image.asset("assets/images/logo3.jpg"),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Column(
                children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff278cbd),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    selectedItemBuilder: (BuildContext context) {
                      return _listPerm.map((value) {
                        return Text(value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg',
                          ),);
                      }).toList();
                    },
                    hint: Text("Pilih jenis pengajuan!",
                      style: TextStyle(
                          color:Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily:'ABZReg'
                      ),),
                    icon: const Icon(Icons.arrow_drop_down_sharp, color:Colors.white,),
                    value: _valPerm,
                    underline: Container(
                      height: 3,
                      color: Colors.white,
                    ),
                    items: _listPerm.map((value) {
                      return DropdownMenuItem<String>(
                        child: Text(value, style: TextStyle(
                            color: Color(0xff278cbd),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valPerm = value;  //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                      });
                    },
                  ),),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: TextField(
                      controller: alasanController,
                      style: TextStyle(color:Colors.white, fontSize:20, fontFamily:'ABZReg', fontWeight: FontWeight.bold,),
                      decoration: InputDecoration(
                        hintText: "Sampaikan alasan anda!",
                        hintStyle: TextStyle(color:Colors.white, fontSize:20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                        ),
                        fillColor: Color(0xff278cbd),
                        filled: true,
                      ),
                      onChanged: (text) {
                        setState(() {
                          alasan = text;
                          //you can access nameController in its scope to get
                          // the value of text entered as shown below
                          //fullName = nameController.text;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: TextField(
                      style: TextStyle(color:Colors.white, fontSize:20, fontFamily:'ABZReg', fontWeight: FontWeight.bold,),
                      decoration: InputDecoration(
                        hintText: "Pilih tanggal mulai izin!",
                        hintStyle: TextStyle(color:Colors.white, fontSize:20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                        ),
                        fillColor: Color(0xff278cbd),
                        filled: true,
                      ),
                      controller: dateinputStart,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                        );
                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);//formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement
                        setState(() {
                          dateinputStart.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Tanggal belum dipilih");
                        }
                      }
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: TextField(
                        style: TextStyle(color:Colors.white, fontSize:20, fontFamily:'ABZReg', fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(
                          hintText: "Pilih tanggal selesai izin!",
                          hintStyle: TextStyle(color:Colors.white, fontSize:20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff278cbd), width: 2)
                          ),
                          fillColor: Color(0xff278cbd),
                          filled: true,
                        ),
                        controller: dateinputEnd,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );
                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);//formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              dateinputEnd.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Tanggal belum dipilih");
                          }
                        }
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.red,
                        onPressed: () {},
                        child: Text("BATAL",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                fontWeight: FontWeight.bold,
                                fontFamily:'ABZReg',
                                color: Colors.white)),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SIMPAN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily:'ABZReg',
                              fontSize: 16,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff278cbd),
        title: Text('PENGAJUAN IZIN',
          style: TextStyle(
            fontFamily:'ABZReg',
            color:Colors.white,
            fontSize: 22  ,
            fontWeight: FontWeight.bold,),
        ),
      ),
      body:
      Center(
          child: _listPage[_selectedTabIndex]
      ),
      drawer: _buildDrawer(),

    );
  }

  Widget _buildDrawer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:[
            DrawerHeader(
              child: Row(children:<Widget>[
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4), // Border radius
                    child: ClipOval(child: Image.asset("assets/images/profile.jpg")),
                  ),
                ),
                VerticalDivider(
                  color: Color(0xff278cbd),
                  thickness: 25.0,
                ),
                Text('Borneo\nSatria\nPratama',
                  style: TextStyle(
                      color:Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily:'ABZReg'
                  ),
                ),
              ],),
              decoration:BoxDecoration(
                color:Color(0xff278cbd),
              ),
            ),

            _buildListTile(Icons.house_rounded, "Beranda", null, HomePage()),
            _buildListTile(Icons.perm_contact_calendar_rounded, "Histori Presensi", null, History()),
            _buildListTile(Icons.contact_mail_outlined, "Pengajuan Izin", null, BossPermission()),
            _buildListTile(Icons.monetization_on_outlined, "Slip Gaji", null, Salary()),
            _buildListTile(Icons.settings, "Pengaturan", null, SettingsPage()),
            Divider(
              height: 20.0,
            ),
            _buildListTile(null, "Logout", Icons.input, SettingsPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      IconData? iconLeading,
      String title,
      IconData? iconTrailing,
      Widget PindahYuk,
      ) {
    return ListTile(
      leading: Icon(iconLeading),
      title: Text(title),
      trailing: Icon(iconTrailing),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PindahYuk,
          ),
        );
      },
    );
  }
}