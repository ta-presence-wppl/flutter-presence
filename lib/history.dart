import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:wppl_frontend/api/api_routes.dart';
import 'package:wppl_frontend/home_page.dart';
import 'package:wppl_frontend/models/m_history.dart';
import 'package:wppl_frontend/settings_page.dart';
import 'package:wppl_frontend/salary.dart';
import 'package:wppl_frontend/boss_permission.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  int _selectedTabIndex = 0;
  final ApiRoutes _apiRoutes = ApiRoutes();

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff278cbd),
        title: const Text(
          'Histori Presensi',
          style: TextStyle(
            fontFamily: 'ABZReg',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: FutureBuilder(
            future: _apiRoutes.getHistoryAbsen(context,
                '2022-05-26'), // a previously-obtained Future<String> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<MHistori>?> snapshot) {
              if (snapshot.hasError) {
                return const Text("Gagal mengambil");
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<MHistori>? finalData = snapshot.data;
                return _buildListHistori(finalData ?? []);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      //drawer: _buildDrawer(),
    );
  }

  Widget _buildListHistori(List<MHistori> myData) {
    return myData.isNotEmpty
        ? ListView.builder(
            primary: false,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              MHistori? data = myData[index];
              return Card(
                child: Column(
                  children: [
                    Text(data.tanggal!),
                    CachedNetworkImage(
                      imageUrl: data.fotoMsk!,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    // Image.network(
                    //   data.fotoMsk!,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return const Text('Gambar tidak ditemukan...');
                    //   },
                    // ),
                  ],
                ),
              );
            },
            itemCount: myData.length,
          )
        : const Text("Kosong!");
  }
}
