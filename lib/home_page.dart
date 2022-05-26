import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wppl_frontend/api/api_routes.dart';
import 'package:wppl_frontend/map_screen.dart';
import 'package:wppl_frontend/models/m_response.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/boss_permission.dart';
import 'package:wppl_frontend/history.dart';
import 'package:wppl_frontend/salary.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedTabIndex = 0;
  //Future<String> _name;
  final picker = ImagePicker();
  File? uploadimage;
  final ApiRoutes _apiRoutes = ApiRoutes();

  @override
  void initState() {
    super.initState();
    // _name = _prefs.then((SharedPreferences value) {
    //   return value.getString('nama');
    // });
  }

  Future<String> getShared(String key) async {
    String v = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key) ?? '-';
    });
    return v;
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void chooseImage() async {
    try {
      var choosedimage =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (choosedimage != null) {
        // setState(() {
        //   uploadimage = File(choosedimage.path);
        // });
        _apiRoutes.absentIN(File(choosedimage.path)).then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil Absen Masuk!'),
                ),
              ),
            );
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Berhasil Absen Masuk!'),
        // ));
        //base64Image = base64Encode(File(choosedimage.path).readAsBytesSync());
      }
    } catch (e) {
      print(e);
    }
    //return choosedimage;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedHour = DateFormat('HH:mm ').format(now);

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );
    final _listPage = <Widget>[
      /* Work From Home */
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            child: Container(
              width: 390,
              child: Text(
                '             Tanggal  :  ' +
                    formattedDate +
                    ' \n                 Pukul  :  ' +
                    formattedHour,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'ABZReg',
                  color: Color(0xff278cbd),
                ),
              ),
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff278cbd)),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 55),
              ElevatedButton.icon(
                icon: Icon(Icons.access_time_rounded),
                label: Text(
                  "Presensi Masuk",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  chooseImage();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  primary: Color(0xff278cbd),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.access_alarms_rounded),
                label: Text(
                  "Presensi Pulang",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  primary: Color(0xff278cbd),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Container(
            child: Text(
              "Lokasi WFH anda saat ini:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff278cbd),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 24,
              ),
            ),
            margin: EdgeInsets.all(16.0),
          ),
          Container(
            height: 327,
            child: MapScreen(),
          ),
        ],
      ),

      /* Work From Office */
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            child: Container(
              width: 390,
              child: Text(
                '             Tanggal  :  ' +
                    formattedDate +
                    ' \n                 Pukul  :  ' +
                    formattedHour,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'ABZReg',
                  color: Color(0xff278cbd),
                ),
              ),
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff278cbd)),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 55),
              ElevatedButton.icon(
                icon: Icon(Icons.access_time_rounded),
                label: Text(
                  "Presensi Masuk",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  primary: Color(0xff278cbd),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.access_alarms_rounded),
                label: Text(
                  "Presensi Pulang",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  primary: Color(0xff278cbd),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Container(
            child: Text(
              "Lokasi WFO anda saat ini:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff278cbd),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 24,
              ),
            ),
            margin: EdgeInsets.all(16.0),
          ),
          Container(
            height: 327,
            child: MapScreen(),
          ),
        ],
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Work From Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city_outlined),
          label: 'Work From Office',
        ),
      ],
      selectedLabelStyle: TextStyle(fontSize: 16),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      currentIndex: _selectedTabIndex,
      iconSize: 36,
      selectedItemColor: Color(0xff278cbd),
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff278cbd),
        title: Text(
          'BERANDA',
          style: TextStyle(
            fontFamily: 'ABZReg',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(child: _listPage[_selectedTabIndex]),
      drawer: _buildDrawer(),
      bottomNavigationBar: _bottomNavBar,
    );
  }

  Widget _buildDrawer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4), // Border radius
                      child: ClipOval(
                          child: Image.asset("assets/images/profile.jpg")),
                    ),
                  ),
                  VerticalDivider(
                    color: Color(0xff278cbd),
                    thickness: 25.0,
                  ),
                  // Text(
                  //   'Borneo\nSatria\nPratama',
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.bold,
                  //       fontFamily: 'ABZReg'),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: getShared(
                            'nama'), // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text('' + snapshot.data!);
                          }
                          return Text('Gagal');
                        },
                      ),
                      FutureBuilder<String>(
                        future: getShared(
                            'email'), // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text('' + snapshot.data!);
                          }
                          return Text('Gagal');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xff278cbd),
              ),
            ),
            _buildListTile(Icons.house_rounded, "Beranda", null, HomePage()),
            // _buildListTile(Icons.perm_contact_calendar_rounded,
            //     "Histori Presensi", null, History()),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              leading: Icon(Icons.history, color: Colors.grey, size: 25),
              title: Text(
                'Histori Presensi',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/histori');
              },
            ),
            _buildListTile(Icons.contact_mail_outlined, "Pengajuan Izin", null,
                BossPermission()),
            // _buildListTile(
            //     Icons.monetization_on_outlined, "Slip Gaji", null, Salary()),

            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              leading:
                  Icon(Icons.person_pin_outlined, color: Colors.grey, size: 25),
              title: Text(
                'Slip Gaji',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/salary');
              },
            ),
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
        Navigator.pop(context);
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
