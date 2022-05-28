import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/history.dart';
import 'package:wppl_frontend/boss_permission.dart';

class Salary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SalaryState();
  }
}
class SalaryState extends State<Salary> {
  int _selectedTabIndex = 0;
  void _onNavBarTapped(int index){
    setState((){
      _selectedTabIndex = index;
    });
  }
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),);
    final _listPage = <Widget>[
      // Program untuk halaman ditulis di dalam sini
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
                      child: Image.asset("assets/images/logo4.jpg"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xff278cbd)),
                    columns: [
                    DataColumn(
                      label:Center(
                        child:Text('Bulan',
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily:'ABZReg'
                        ),
                    ),),),
                    DataColumn(
                      label:Center(
                        child:Text('Unduh!',
                          style: TextStyle(
                              color:Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily:'ABZReg'
                          ),
                      ),),),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Mei 2022',
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),),
                      DataCell(Center(child:
                        Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                    DataRow(cells: [
                      DataCell(Text('April 2022',
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),),
                      DataCell(Center(child:
                      Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                    DataRow(cells: [
                      DataCell(Text('Maret 2022',
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),),
                      DataCell(Center(child:
                      Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                    DataRow(cells: [
                      DataCell(Text('Februari 2022',
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),),
                      DataCell(Center(child:
                      Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                    DataRow(cells: [
                      DataCell(Text('Januari 2022',
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily:'ABZReg'
                        ),),),
                      DataCell(Center(child:
                      Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                    DataRow(cells: [
                    DataCell(Text('Desember 2021',
                        style: TextStyle(
                        color:Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                      ),),),
                      DataCell(Center(child:
                        Icon(Icons.download_rounded, size: 32, color: Color(0xff278cbd),),
                      ),)
                    ],),
                ]),],
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff278cbd),
        title: Text('SLIP GAJI',
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