import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmchem/DataModel.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/database.dart';
import 'package:pharmchem/home_screen.dart';

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
    super.initState();
    db = DB();
  }

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
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Your prescription",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.file(ScannedText.cropppedImg),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Scanned text",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(ScannedText.predictedText),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(color: primaryColor),
                      child: Text("Save prescription"),
                    ),
                    onTap: () {
                      db.insertData(Prescription(
                          image: ScannedText.bas64Img,
                          ScannedText: ScannedText.predictedText));
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
