import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:intl/intl.dart';
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
  String _valMonthNum = "01";
  final List _listMonth = [
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
  final _now = DateTime.now();
  final _formatter = DateFormat('yyyy');
  final ApiRoutes _apiRoutes = ApiRoutes();
  String formattedDate = "";
  @override
  void initState() {
    super.initState();
    formattedDate = _formatter.format(_now);
  }

  String _parseDate(String _myDate) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(_myDate); // 2022-06-07

    var outputFormat = DateFormat('EEEE, dd MMM yyyy');
    return outputFormat.format(inputDate);
  }

  String _parseTime(String _myDate) {
    var inputFormat = DateFormat('H:m:sz');
    if (_myDate == '-') {
      return '-';
    }
    var inputDate = inputFormat.parse(_myDate); // 20:48:57+07

    var outputFormat = DateFormat('H:mm');
    return outputFormat.format(inputDate);
  }

  void _getNumMonth(String _name) {
    List.generate(_listMonth.length,
        (i) => _listMonth[i] == _name ? _valMonthNum = (i + 1).toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    /*
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );
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
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff278cbd),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    selectedItemBuilder: (BuildContext context) {
                      return _listMonth.map((value) {
                        return Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ABZReg',
                          ),
                        );
                      }).toList();
                    },
                    hint: Text(
                      "Pilih bulan presensi!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg'),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ),
                    value: _valMonth,
                    underline: Container(
                      height: 3,
                      color: Colors.white,
                    ),
                    items: _listMonth.map((value) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Color(0xff278cbd),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ABZReg'),
                        ),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valMonth =
                            value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Color(0xff278cbd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Kamis, 26 Mei 2022',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg'),
                    ),
                    Divider(color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '07:49',
                                  style: TextStyle(
                                      color: Color(0xffc2e5d3),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Pulang',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '17:22',
                                  style: TextStyle(
                                      color: Color(0xffc2e5d3),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Kamis, 25 Mei 2022',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg'),
                    ),
                    Divider(color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '08:05',
                                  style: TextStyle(
                                      color: Color(0xffff8484),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Pulang',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '17:03',
                                  style: TextStyle(
                                      color: Color(0xffc2e5d3),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Kamis, 24 Mei 2022',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg'),
                    ),
                    Divider(color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 5.0),
                          child: Text(
                            'Anda Tidak Presensi',
                            style: TextStyle(
                                color: Color(0xffff8484),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ABZReg'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xff278cbd),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Kamis, 23 Mei 2022',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ABZReg'),
                    ),
                    Divider(color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '07:58',
                                  style: TextStyle(
                                      color: Color(0xffc2e5d3),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  'Presensi Pulang',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '17:15',
                                  style: TextStyle(
                                      color: Color(0xffc2e5d3),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ABZReg'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    ];
    */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff278cbd),
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xff278cbd),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          selectedItemBuilder: (BuildContext context) {
                            return _listMonth.map((value) {
                              return Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ABZReg',
                                ),
                              );
                            }).toList();
                          },
                          hint: const Text(
                            "Pilih bulan presensi!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ABZReg'),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                          value: _valMonth,
                          underline: Container(
                            height: 3,
                            color: Colors.white,
                          ),
                          items: _listMonth.map((value) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Color(0xff278cbd),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ABZReg'),
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            _getNumMonth(value ?? '');
                            setState(() {
                              _valMonth =
                                  value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _apiRoutes.getHistoryAbsen(
                  context,
                  formattedDate +
                      '-' +
                      _valMonthNum +
                      '-26'), // a previously-obtained Future<String> or null
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
          ],
        ),
      ),
    );
  }

  Widget _buildListHistori(List<MHistori> myData) {
    return myData.isNotEmpty
        ? Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  MHistori? data = myData[index];
                  return Card(
                    color: const Color(0xff278cbd),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _parseDate(data.tanggal!),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ABZReg'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, bottom: 5.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Presensi Masuk',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ABZReg'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _parseTime(data.jamMsk!),
                                      style: const TextStyle(
                                          color: Color(0xffc2e5d3),
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ABZReg'),
                                    ),
                                  ],
                                )),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Presensi Pulang',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ABZReg'),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _parseTime(data.jamPlg ?? '-'),
                                    style: const TextStyle(
                                        color: Color(0xffc2e5d3),
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ABZReg'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: myData.length,
              ),
            ),
          )
        : const Text("Kosong!");
  }
}
