import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/edit_screen.dart';
import 'package:pharmchem/home_screen.dart';
import 'package:pharmchem/scanResult_screen.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qrFile extends StatefulWidget {
  const qrFile({super.key});

  @override
  State<qrFile> createState() => _qrFileState();
}

class _qrFileState extends State<qrFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'QR File',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
              Text(
                ScannedText.predictedText,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'QR CODE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              QrImage(
                data: ScannedText.predictedText,
                version: QrVersions.auto,
                size: 150,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    searchResult();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return scanResult();
                    }));
                  },
                  child: Text("Next")),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
