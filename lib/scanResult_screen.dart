import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmchem/DataModel.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/database.dart';
import 'package:pharmchem/edit_screen.dart';
import 'package:pharmchem/home_screen.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EditClass {
  static late String editData;
  static late int index;
}

void EditFunction() {}

class scanResult extends StatefulWidget {
  const scanResult({super.key});

  @override
  State<scanResult> createState() => _scanResultState();
}

class _scanResultState extends State<scanResult> {
  // late File decodedImg;

  // void getImage() {
  //   // decodedImg = base64Decode(ScannedText.bas64Img) as File;
  // }
  late DB db;
  @override
  void initState() {
    setState(() {});
    super.initState();
    db = DB();
    textEditingController = TextEditingController();
  }

  // List qrList = [];
  // String qrData = '';
  bool _isEdit = false;
  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                "Symptoms",
                style: TextStyle(fontSize: 40),
              ),
            ),
            Divider(
              height: 1,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: PrepopulatedData.resSym.length,
              // itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          PrepopulatedData.resSym[index],
                          // "Headache",
                          style: TextStyle(fontSize: 19),
                        ),
                        //     TextField(
                        //   controller: textEditingController,
                        //   decoration: InputDecoration(
                        //       // hintText: PrepopulatedData.resSym[index]),
                        //       hintText: 'Sample Text'),
                        //   // hint PrepopulatedData.resSym[index],
                        //   style: TextStyle(fontSize: 18),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {
                              EditClass.editData =
                                  PrepopulatedData.resSym[index];
                              EditClass.index = index;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const editScreen(),
                                  ));
                            },
                            icon: Icon(Icons.edit)),
                      )
                    ],
                  ),
                  // trailing:
                  //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                );
              },
            ),
            Container(
              // width: 400,
              // decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                "Medicines",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ),
            Divider(
              height: 1,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: PrepopulatedData.resMed.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index.isEven
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/doctor-s-prescription.appspot.com/o/Medicines%2FBENADRYL?alt=media&token=2161cc44-e700-479e-8424-669b1251ec07'),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/doctor-s-prescription.appspot.com/o/Medicines%2FCROCIN?alt=media&token=b373b505-b015-420c-ba28-d59e6398a1a9'),
                              ),
                            ),
                      Text(
                        PrepopulatedData.resMed[index],
                        style: TextStyle(fontSize: 19),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.edit)),
                      )
                    ],
                  ),
                  // trailing:
                  //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                );
              },
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       for (var i = 0; i < PrepopulatedData.resMed.length; i++) {
            //         qrList.add(PrepopulatedData.resMed[i]);
            //       }
            //       for (var i = 0; i < qrList.length; i++) {
            //         qrData += qrList[i];
            //       }
            //     },
            //     child: Text("Generate QR")),
            SizedBox(
              height: 50,
            ),
            // QrImage(
            //     data: ScannedText.predictedText,
            //     version: QrVersions.auto,
            //     size: 200.0),
          ],
        ),
      ),
    );
  }
}
