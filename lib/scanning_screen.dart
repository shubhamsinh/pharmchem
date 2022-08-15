// import 'dart:html';

import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmchem/components/navbar.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/home_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = '';
  // late File fileData;

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        // textScanning = true;
        imageFile = pickedImage;
        final bytes = Io.File(
                'E:/Study data/Smart India Hackathon/pharmchem/assets/images/Asma_Khan.png')
            .readAsBytesSync();
        String img64 = base64Encode(bytes);
        print(img64);
        setState(() {});
        // getRecognizedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error occured while scanning";
    }
  }

  // void getRecognizedText(XFile image) async {
  //   final inputImage = InputImage.fromFilePath(image.path);
  //   final textDetector = GoogleMlKit.vision.textRecognizer();
  //   RecognizedText recognizedText = await textDetector.processImage(inputImage);
  //   await textDetector.close();
  //   scannedText = "";
  //   for (TextBlock block in recognizedText.blocks) {
  //     for (TextLine line in block.lines) {
  //       scannedText = scannedText + line.text + "\n";
  //     }
  //   }
  //   textScanning = false;
  //   setState(() {});
  // }

  void initState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scan"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[300]!,
                ),
              if (imageFile != null) Image.file(Io.File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        shadowColor: Colors.grey[400],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        // final imageBytes =
                        //     Io.File('')readAsBytesSync();
                        // print(imageBytes);
                        // String base64Image = base64Encode(imageBytes);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        shadowColor: Colors.grey[400],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  scannedText,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: navBar(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              selectedIndex: 1,
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: primaryColor,
              padding: EdgeInsets.all(8),
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }),
                GButton(
                    icon: Icons.document_scanner_outlined,
                    text: 'Scan',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanScreen()));
                    }),
                GButton(
                  icon: Icons.library_books,
                  text: 'Prescription',
                  // onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PrescScreen()));
                  //   }
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  // onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProfileScreen()));
                  //   }
                ),
              ]),
        ),
      ),
    );
  }
}
