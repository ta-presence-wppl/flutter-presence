import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:wppl_frontend/models/m_history.dart';
import 'package:wppl_frontend/models/m_response.dart';

class ApiRoutes {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String _baseAPI =
      "https://api-ta-presence-gateaway.behindrailstudio.com";

  Future<MResponse?> absentIN(
      File fileImage, String? _latitude, String? _longitude) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Authorization': token,
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData =
          dio.FormData.fromMap({'lokasi_msk': '$_latitude, $_longitude'});

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(fileImage.path,
          filename: basename(fileImage.path),
          contentType: MediaType("image", basename(fileImage.path)));

      formData.files.add(MapEntry('image', file));

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        '/absent_service/absent/in',
        data: formData,
      );
      return responseData(response.data);
    } catch (err) {
      Map<String, dynamic> retval = {"message": "Anda Telah Absen Hari Ini!"};
      return responseData(retval);
    }
  }

  Future<MResponse?> absentOut(
      File fileImage, String? _latitude, String? _longitude) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Authorization': token,
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData =
          dio.FormData.fromMap({'lokasi_plg': '$_latitude, $_longitude'});

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(fileImage.path,
          filename: basename(fileImage.path),
          contentType: MediaType("image", basename(fileImage.path)));

      formData.files.add(MapEntry('image', file));

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        '/absent_service/absent/out',
        data: formData,
      );
      return responseData(response.data);
    } catch (err) {
      Map<String, dynamic> retval = {"message": "Anda Telah Absen Hari Ini!"};
      return responseData(retval);
    }
  }

  Future<MResponse?> getAbsenStatus(BuildContext context) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;

      dioRequest.options.responseType = dio.ResponseType.json;

      ///[2] ADDING TOKEN
      dioRequest.options.headers = {'Authorization': token};

      ///[3] SEND TO SERVER
      var response = await dioRequest.get('/absent_service/absent/status');
      return responseData(response.data);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Kesalahan pada Server!'),
      ));
    }
  }

  Future<List<MHistori>?> getHistoryAbsen(
      BuildContext context, String myDate) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;

      dioRequest.options.responseType = dio.ResponseType.json;

      ///[2] ADDING TOKEN
      dioRequest.options.headers = {'Authorization': token};

      ///[3] SEND TO SERVER
      Response<String> response =
          await dioRequest.get('/absent_service/absent/history?date=' + myDate);
      return responseHistori(response.data);
      print('tes');
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Kesalahan pada Server!'),
      ));
    }
  }

  //Izin
  Future<MResponse?> izinIN(File fileImage, String? _jenis, String? _ket,
      String? _tglAwal, String? _tglAkhir) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Authorization': token,
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData = dio.FormData.fromMap({
        'jenis_izin': '$_jenis',
        'ket': '$_ket',
        'tgl_awal': '$_tglAwal',
        'tgl_akhir': '$_tglAkhir'
      });

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(fileImage.path,
          filename: basename(fileImage.path),
          contentType: MediaType("image", basename(fileImage.path)));

      formData.files.add(MapEntry('image', file));

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        '/izin_service/izin',
        data: formData,
      );
      return responseData(response.data);
    } catch (err) {
      Map<String, dynamic> retval = {
        "message": "Anda Telah Mengajukan Izin Hari Ini"
      };
      return responseData(retval);
    }
  }

  //Settings
  Future<MResponse?> putSettings(BuildContext context, String? nama,
      String? email, String? password) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');
      final dataSend = <String, String>{'': ''};
      final nameAdd = <String, String>{'nama': nama!};
      final emailAdd = <String, String>{'email': email!};
      final passwordAdd = <String, String>{'password': password!};

      if (nama != '') {
        dataSend.addEntries(nameAdd.entries);
      }
      if (email != '') {
        dataSend.addEntries(emailAdd.entries);
      }
      if (password != '') {
        dataSend.addEntries(passwordAdd.entries);
      }

      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = _baseAPI;
      dioRequest.options.responseType = dio.ResponseType.json;

      ///[2] ADDING TOKEN
      dioRequest.options.headers = {'Authorization': token};

      ///[3] SEND TO SERVER
      var response = await dioRequest.put('/auth_service/settings/update-user',
          data: dataSend);
      return responseData(response.data);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Kesalahan pada Server!'),
      ));
    }
  }
}
