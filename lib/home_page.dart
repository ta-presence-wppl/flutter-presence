import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wppl_frontend/api/api_routes.dart';
import 'package:wppl_frontend/map_screen.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/boss_permission.dart';
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
  Location currentLocation = Location();
  final picker = ImagePicker();
  File? uploadimage;
  final ApiRoutes _apiRoutes = ApiRoutes();
  String? _latitude, _longitude, _statusAbsent = "";

  @override
  void initState() {
    super.initState();
    getLatLong();
    getInfo();
  }

  void getLatLong() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      setState(() {
        _latitude = loc.latitude.toString();
        _longitude = loc.longitude.toString();
      });
    });
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
        _apiRoutes
            .absentIN(File(choosedimage.path), _latitude, _longitude)
            .then(
              (value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value!.responseMessage!),
                  ),
                ),
              },
            );
      }
    } catch (e) {
      print(e);
    }
  }

  void chooseImageOut() async {
    try {
      var choosedimage =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (choosedimage != null) {
        _apiRoutes
            .absentOut(File(choosedimage.path), _latitude, _longitude)
            .then(
              (value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value!.responseMessage!),
                  ),
                ),
              },
            );
      }
    } catch (e) {
      print(e);
    }
  }

  void getInfo() async {
    await _apiRoutes.getAbsenStatus(context).then((_user) {
      _statusAbsent = _user!.responseMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedHour = DateFormat('HH:mm ').format(now);

    final _listPage = <Widget>[
      /* Work From Home */
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
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
              border: Border.all(color: const Color(0xff278cbd)),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 55),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_time_rounded),
                label: const Text(
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
                  primary: const Color(0xff278cbd),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_alarms_rounded),
                label: const Text(
                  "Presensi Pulang",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  chooseImageOut();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  primary: const Color(0xff278cbd),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Container(
            child: Text(
              _statusAbsent!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 141, 9),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 14,
              ),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          Container(
            child: const Text(
              "Lokasi WFH anda saat ini:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff278cbd),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 24,
              ),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          SizedBox(
            height: 300,
            child: MapScreen(),
          ),
        ],
      ),

      /* Work From Office */
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
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
              border: Border.all(color: const Color(0xff278cbd)),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 55),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_time_rounded),
                label: const Text(
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
                  primary: const Color(0xff278cbd),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_alarms_rounded),
                label: const Text(
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
                  primary: const Color(0xff278cbd),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Container(
            child: Text(
              _statusAbsent!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 141, 9),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 14,
              ),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          Container(
            child: const Text(
              "Lokasi WFO anda saat ini:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff278cbd),
                fontWeight: FontWeight.bold,
                fontFamily: 'ABZReg',
                fontSize: 24,
              ),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          SizedBox(
            height: 300,
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
      selectedLabelStyle: const TextStyle(fontSize: 16),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      currentIndex: _selectedTabIndex,
      iconSize: 36,
      selectedItemColor: const Color(0xff278cbd),
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff278cbd),
        title: const Text(
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
                  const VerticalDivider(
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
                          return const Text('Gagal');
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
                          return const Text('Gagal');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Color(0xff278cbd),
              ),
            ),
            //_buildListTile(Icons.house_rounded, "Beranda", null, '/home'),
            _buildListTile(Icons.perm_contact_calendar_rounded,
                "Histori Presensi", null, '/histori'),
            _buildListTile(Icons.contact_mail_outlined, "Pengajuan Izin", null,
                '/pengajuan_izin'),
            _buildListTile(
                Icons.monetization_on_outlined, "Slip Gaji", null, '/salary'),
            _buildListTile(Icons.settings, "Pengaturan", null, '/pengaturan'),
            const Divider(
              height: 20.0,
            ),
            _buildListTile(null, "Logout", Icons.input, ''),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    IconData? iconLeading,
    String title,
    IconData? iconTrailing,
    String route,
  ) {
    return ListTile(
      leading: Icon(iconLeading),
      title: Text(title),
      trailing: Icon(iconTrailing),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
