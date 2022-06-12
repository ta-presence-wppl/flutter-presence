import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wppl_frontend/api/api_routes.dart';

class BossPermission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BossPermissionState();
  }
}

class BossPermissionState extends State<BossPermission> {
  String? _valPerm;
  final picker = ImagePicker();
  final ApiRoutes _apiRoutes = ApiRoutes();
  File? uploadimage;
  final List _listPerm = [
    "Sakit",
    "Izin",
  ];
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  TextEditingController alasanController = TextEditingController();
  String alasan = '';
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    dateinputStart.text = "";
    dateinputEnd.text = "";
    uploadimage = null; //set the initial value of text field
  }

  void chooseImage() async {
    try {
      var choosedimage =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

      if (choosedimage != null) {
        setState(() {
          uploadimage = File(choosedimage.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gambar tidak dapat diambil!'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void sendizin() async {
    if (uploadimage != null &&
        _valPerm != '' &&
        alasanController.text != '' &&
        dateinputEnd.text != '' &&
        dateinputStart.text != '') {
      await _apiRoutes
          .izinIN(uploadimage!, _valPerm, alasanController.text,
              dateinputStart.text, dateinputEnd.text)
          .then(
            (value) => {
              setState(() {
                uploadimage = null;
                _valPerm = null;
              }),
              alasanController.clear(),
              dateinputStart.clear(),
              dateinputEnd.clear(),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value!.responseMessage!),
                ),
              ),
            },
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon Lengkapi Form Isian!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
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
              const SizedBox(
                height: 35,
              ),
              Column(
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
                        return _listPerm.map((value) {
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
                        "Pilih jenis pengajuan!",
                        style: TextStyle(
                            color: Color.fromARGB(150, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ABZReg'),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.white,
                      ),
                      value: _valPerm,
                      underline: Container(
                        height: 3,
                        color: Colors.white,
                      ),
                      items: _listPerm.map((value) {
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
                        setState(() {
                          _valPerm =
                              value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextField(
                      controller: alasanController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'ABZReg',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Sampaikan alasan anda!",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff278cbd), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff278cbd), width: 2)),
                        fillColor: const Color(0xff278cbd),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'ABZReg',
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "Pilih tanggal mulai izin!",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(150, 255, 255, 255),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xff278cbd), width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xff278cbd), width: 2)),
                          fillColor: Color(0xff278cbd),
                          filled: true,
                        ),
                        controller: dateinputStart,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              dateinputStart.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Tanggal belum dipilih");
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff278cbd),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'ABZReg',
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "Pilih tanggal selesai izin!",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(150, 255, 255, 255),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xff278cbd), width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xff278cbd), width: 2)),
                          fillColor: const Color(0xff278cbd),
                          filled: true,
                        ),
                        controller: dateinputEnd,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              dateinputEnd.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Tanggal belum dipilih");
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  uploadimage != null
                      ? Container()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: const Text(
                              "Ambil Bukti Foto",
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
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  uploadimage != null
                      ? Image(image: FileImage(uploadimage!))
                      : Container(),
                  uploadimage != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: const Text(
                              "Hapus Foto",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                uploadimage = null;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              primary: Color.fromARGB(255, 189, 56, 39),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          "Ajukan",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          sendizin();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          primary: Colors.green,
                        ),
                      ),
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
        backgroundColor: const Color(0xff278cbd),
        title: const Text(
          'Pengajuan Izin',
          style: TextStyle(
            fontFamily: 'ABZReg',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(child: _listPage[0]),
    );
  }
}
