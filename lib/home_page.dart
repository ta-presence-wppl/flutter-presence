import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wppl_frontend/api/api_routes.dart';
import 'package:wppl_frontend/login_view.dart';
import 'package:wppl_frontend/map_screen.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/boss_permission.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedTabIndex = 0;
  Location currentLocation = Location();
  final picker = ImagePicker();
  File? uploadimage;
  final ApiRoutes _apiRoutes = ApiRoutes();
  String? _latitude, _longitude;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getLatLong();
  }

  Future<void> getLatLong() async {
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

  Future<void> _refresh() async {
    setState(() {});
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
                getInfo(),
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
                getInfo(),
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

  Future<String> getInfo() async {
    String? res = await _apiRoutes.getAbsenStatus(context).then((_user) {
      return _user!.responseMessage;
    });
    return res!;
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  void dispose() {
    super.dispose();
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
            width: MediaQuery.of(context).size.width,
            child: Text(
              formattedDate + '\n' + formattedHour,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'ABZReg',
                color: Color(0xff278cbd),
              ),
              textAlign: TextAlign.center,
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
                    fontSize: 16,
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
                    fontSize: 16,
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
            child: FutureBuilder<String>(
              future: getInfo(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        '${snapshot.data}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 35, 141, 9),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg',
                          fontSize: 14,
                        ),
                      );
                    }
                }
              },
            ),
            margin: const EdgeInsets.all(16.0),
          ),
          // Container(
          //   child: Text(
          //     _statusAbsent!,
          //     textAlign: TextAlign.left,
          //     style: const TextStyle(
          //       color: Color.fromARGB(255, 35, 141, 9),
          //       fontWeight: FontWeight.bold,
          //       fontFamily: 'ABZReg',
          //       fontSize: 14,
          //     ),
          //   ),
          //   margin: const EdgeInsets.all(16.0),
          // ),
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
            width: MediaQuery.of(context).size.width,
            child: Text(
              formattedDate + '\n' + formattedHour,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'ABZReg',
                color: Color(0xff278cbd),
              ),
              textAlign: TextAlign.center,
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
          // Container(
          //   child: Text(
          //     _statusAbsent!,
          //     textAlign: TextAlign.left,
          //     style: const TextStyle(
          //       color: Color.fromARGB(255, 35, 141, 9),
          //       fontWeight: FontWeight.bold,
          //       fontFamily: 'ABZReg',
          //       fontSize: 14,
          //     ),
          //   ),
          //   margin: const EdgeInsets.all(16.0),
          // ),
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
          'Beranda',
          style: TextStyle(
            fontFamily: 'ABZReg',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: <Widget>[
            ListView(
                physics: const AlwaysScrollableScrollPhysics(), children: []),
            _listPage[_selectedTabIndex],
          ]),
        ),
      ),
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
                          child: Image.asset("assets/images/profile-2.png")),
                    ),
                  ),
                  const VerticalDivider(
                    color: Color(0xff278cbd),
                    thickness: 25.0,
                  ),
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
                            return Text(
                              '' + snapshot.data!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABZReg'),
                            );
                          }
                          return const Text('Gagal');
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<String>(
                        future: getShared(
                            'email'), // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '' + snapshot.data!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABZReg'),
                            );
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
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.grey, size: 25),
              title: const Text(
                'Logout',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
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
