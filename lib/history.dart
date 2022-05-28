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
  String? _valMonth;
  List _listMonth = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
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
            children: [ SingleChildScrollView(child:
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
                    return _listMonth.map((value) {
                      return Text(value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily:'ABZReg',
                      ),);
                    }).toList();
                  },
                  hint: Text("Pilih bulan presensi!",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                    ),),
                  icon: const Icon(Icons.arrow_drop_down_sharp, color:Colors.white,),
                  value: _valMonth,
                  underline: Container(
                    height: 3,
                    color: Colors.white,
                  ),
                  items: _listMonth.map((value) {
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
                      _valMonth = value;  //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                    });
                  },
                ),),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
              padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(
                  Radius.circular(10.0)),
                ),
                child: Column(children:[
                  Text('Kamis, 26 Mei 2022',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                    ),),
                  Divider(
                      color: Colors.white
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                      child: Column(children:[
                        Text('Presensi Masuk',
                          style: TextStyle(
                              color:Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily:'ABZReg'
                          ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('07:49',
                          style: TextStyle(
                              color: Color(0xffc2e5d3),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily:'ABZReg'
                          ),),
                      ],)
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Column(children:[
                          Text('Presensi Pulang',
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily:'ABZReg'
                            ),),
                          SizedBox(
                            height: 5,
                          ),
                          Text('17:22',
                            style: TextStyle(
                                color: Color(0xffc2e5d3),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily:'ABZReg'
                            ),),
                        ],)
                    )
                  ],),
                ],),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                ),
                child: Column(children:[
                  Text('Kamis, 25 Mei 2022',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                    ),),
                  Divider(
                      color: Colors.white
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Column(children:[
                            Text('Presensi Masuk',
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('08:05',
                              style: TextStyle(
                                  color: Color(0xffff8484),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                          ],)
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Column(children:[
                            Text('Presensi Pulang',
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('17:03',
                              style: TextStyle(
                                  color: Color(0xffc2e5d3),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                          ],)
                      )
                    ],),
                ],),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                ),
                child: Column(children:[
                  Text('Kamis, 24 Mei 2022',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                    ),),
                  Divider(
                      color: Colors.white
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Text('Anda Tidak Presensi',
                            style: TextStyle(
                                color: Color(0xffff8484),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily:'ABZReg'
                            ),),
                      )
                    ],),
                ],),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                ),
                child: Column(children:[
                  Text('Kamis, 23 Mei 2022',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:'ABZReg'
                    ),),
                  Divider(
                      color: Colors.white
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Column(children:[
                            Text('Presensi Masuk',
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('07:58',
                              style: TextStyle(
                                  color: Color(0xffc2e5d3),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                          ],)
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Column(children:[
                            Text('Presensi Pulang',
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('17:15',
                              style: TextStyle(
                                  color: Color(0xffc2e5d3),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:'ABZReg'
                              ),),
                          ],)
                      )
                    ],),
                ],),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff278cbd),
        title: Text('HISTORI PRESENSI',
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
