import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:async';

// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pharmchem/components/navbar.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/database.dart';
import 'package:pharmchem/scanResult_screen.dart';
import 'package:pharmchem/scanning_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
// import 'package:image_utils_class/image_utils_class.dart';

class ScannedText {
  static String predictedText = '';
  static String bas64Img = '';
  static late File cropppedImg;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(viewportFraction: 0.92);
  var _currPageValue = 0.0;
  bool isHome = true;
  bool isPrescription = false;
  bool isScan = false;
  bool isProfile = false;

  bool textScanning = false;
  XFile? imageFile;
  String scannedText = '';
  String finalImgPath = '';
  late File finalImg;
  String finalresponse = '';

  void getImage(ImageSource source) async {
    try {
      final PickedFile = await ImagePicker().pickImage(source: source);
      if (PickedFile != null) {
        cropSquare(PickedFile.path);
        // if (finalImg != '') {
        //   final bytes = Io.File(finalImg).readAsBytesSync();
        //   String img64 = base64Encode(bytes);
        //   print(img64);
        //   sendImage(img64);
        // }
        // final bytes = Io.File(finalImg).readAsBytesSync();
        // String img64 = base64Encode(bytes);
        // print(img64);
        // sendImage(img64);
      } else {
        print("No files selected");
      }
    } catch (e) {
      print("no files selected");
    }
  }

  late BuildContext next;
  Future<String> cropSquare(String srcFilePath) async {
    CroppedFile? image = await ImageCropper().cropImage(
      sourcePath: srcFilePath,
      uiSettings: [
        AndroidUiSettings(
          statusBarColor: primaryColor,
          toolbarColor: primaryColor,
          toolbarTitle: 'Crop Image',
          toolbarWidgetColor: Colors.white,
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    String destFilePath = '';
    if (image != null) {
      destFilePath = join((await getTemporaryDirectory()).path,
          '${DateTime.now().millisecondsSinceEpoch}.png');
      File finalImage = await File(image.path).copy(destFilePath);
      finalImgPath = finalImage.path;
      finalImg = finalImage;
      ScannedText.cropppedImg = finalImg;

      base64Image(finalImgPath);
    }
    return destFilePath;
  }

  void base64Image(String imagePath) {
    final bytes = Io.File(finalImgPath).readAsBytesSync();
    String img64 = base64Encode(bytes);
    ScannedText.bas64Img = img64;
    print(img64);
    // confirmImage();

    sendImage(img64);
  }

  var finaltext = '';
  Future sendImage(String img) async {
    var url = Uri.parse("http://192.168.207.86:8000/getImage");
    var strImg = img;
    var data = {
      "image": strImg,
    };
    var response = await http.post(url, body: data);
    print(response);
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonOP = json.decode(response.body);
      finaltext = jsonOP["text"];
      // ScannedText finaltext1 = new ScannedText();
      ScannedText.predictedText = finaltext;
      // finalresponse = jsonDecode(finaltext);

      // = Album.fromJson(jsonDecode(response.body)) as String;
      setState(() {
        Navigator.push(
            next,
            MaterialPageRoute(
              builder: (context) => const scanResult(),
            ));
      });

      print('response recieved');

      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // Future<Album> getRecognisedText() async {
  //   final response =
  //       await http.post(Uri.parse('http://192.168.207.86:8000/getImage'));
  //   print("----------------");
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Album.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  // void getImage(ImageSource source) async {
  // void getImage() {
  // try {
  // final pickedImage = await ImagePicker().pickImage(source: source);
  // if (pickedImage != null) {
  //   textScanning = true;
  //   imageFile = pickedImage;
  // final bytes = Io.File('Phone/DCIM/Snapchat/Snapchat-1176839633.jpg')
  //     .readAsBytesSync();
  // String img64 = base64Encode(bytes);
  // print(img64);
  // setState(() {});
  // getRecognizedText(pickedImage);
  // }
  // } catch (e) {
  //   textScanning = false;
  //   imageFile = null;
  //   setState(() {});
  //   scannedText = "Error occured while scanning";
  // }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   pageController.addListener(() {
  //     setState(() {
  //       _currPageValue = pageController.page!;
  //     });
  //   });
  // }

  // late Future<Album> futureAlbum;

  late DB db;

  @override
  void initState() {
    super.initState();
    db = DB();
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("PharmChem"),
      //   backgroundColor: primaryColor,
      //   // backgroundColor: Colors.white,
      //   // foregroundColor: Colors.black,
      //   centerTitle: true,
      //   elevation: 0,
      //   // automaticallyImplyLeading: false,
      // ),
      body: isHome
          ? Visibility(
              visible: isHome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, Shubham!',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'How are you feeling today?',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/shubham.jpg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        color: Colors.white,
                        height: 220,
                        child: PageView.builder(
                            controller: pageController,
                            itemCount: 2,
                            itemBuilder: (context, position) {
                              return _buildPageItem(position);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 15),
                    child: Text(
                      "How can we help you?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.document_scanner_outlined,
                              size: 30,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Scan',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'prescription',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list,
                              size: 30,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'View',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'prescription',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              size: 30,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Your',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'profile',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, bottom: 15, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "For today",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text('View all',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: 100,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/pill.jpg',
                              height: 100,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crocin 650",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "03:00 PM • After Eating",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color.fromARGB(255, 225, 244, 253),
                              ),
                              height: 32,
                              width: 32,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  // new DotsIndicator(
                  //   dotsCount: 4,
                  //   position: _currPageValue,
                  //   decorator: DotsDecorator(
                  //     color: Colors.grey, // Inactive color
                  //     activeColor: primaryColor,
                  //   ),
                  // ),
                ],
              ),
            )
          : isScan
              ? Visibility(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (textScanning) const CircularProgressIndicator(),
                        if (!textScanning && imageFile == null)
                          // Lottie.network(
                          //     'https://assets10.lottiefiles.com/packages/lf20_tutvdkg0.json'),
                          Lottie.asset('assets/animations/prescription.json'),
                        Text(
                          "Select your prescription to scan",
                          style: TextStyle(fontSize: 20),
                        ),
                        // Container(
                        //   width: 300,
                        //   height: 300,
                        //   // decoration: BoxDecoration(
                        //   //     // image: DecorationImage(
                        //   //     //     image: NetworkImage('finalImg'))),
                        //   color: Colors.grey[300]!,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.image,
                        //         size: 50,
                        //         color: Colors.grey,
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Text(
                        //         "Select a prescription to scan",
                        //         style: TextStyle(
                        //             fontSize: 22, color: Colors.grey),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding,
                                  horizontal: defaultPadding),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    next = context;
                                    getImage(ImageSource.gallery);
                                  },
                                  // onPressed: () async {
                                  //   // final PickedFile = await picker.getImage(
                                  //   //     source: ImageSource.gallery);
                                  //   final PickedFile = await ImagePicker()
                                  //       .pickImage(source: ImageSource.gallery);
                                  //   setState(() {
                                  //     if (PickedFile != null) {
                                  //       final bytes = Io.File(PickedFile.path)
                                  //           .readAsBytesSync();
                                  //       String img64 = base64Encode(bytes);
                                  //       sendImage();
                                  //       img = img64;
                                  //       print(img64);
                                  //       print(img64.length);

                                  //       // print(base64.text);
                                  //     } else {
                                  //       print("No images selected");
                                  //     }
                                  //   });
                                  //   // getImage(ImageSource.gallery);
                                  // },
                                  style: TextButton.styleFrom(
                                    // backgroundColor: Color(0xFF6CD8D1),
                                    elevation: 5,
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: primaryColor),
                                    ),
                                  ),
                                  child: Text("Select from gallery"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding,
                                  horizontal: defaultPadding),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                  style: TextButton.styleFrom(
                                    // backgroundColor: Color(0xFF6CD8D1),
                                    elevation: 5,
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: primaryColor),
                                    ),
                                  ),
                                  child: Text("Capture using camera"),
                                ),
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.symmetric(horizontal: 5),
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       primary: Colors.white,
                            //       onPrimary: Colors.grey,
                            //       shadowColor: Colors.grey[400],
                            //       elevation: 10,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(8.0)),
                            //     ),
                            //     onPressed: () async {
                            //       // final PickedFile = await picker.getImage(
                            //       //     source: ImageSource.gallery);
                            //       final PickedFile = await ImagePicker()
                            //           .pickImage(source: ImageSource.gallery);
                            //       setState(() {
                            //         if (PickedFile != null) {
                            //           // base64.text = ImageUtils.fileToBase64(
                            //           //     Io.File(PickedFile.path));
                            //           final bytes = Io.File(PickedFile.path)
                            //               .readAsBytesSync();
                            //           String img64 = base64Encode(bytes);
                            //           sendImage();
                            //           img = img64;
                            //           print(img64);
                            //           print(img64.length);

                            //           // print(base64.text);
                            //         } else {
                            //           print("No images selected");
                            //         }
                            //       });
                            //       // getImage(ImageSource.gallery);
                            //     },
                            //     child: Container(
                            //       margin: const EdgeInsets.symmetric(
                            //           vertical: 1, horizontal: 120),
                            //       child: Column(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           Icon(
                            //             Icons.image,
                            //             size: 30,
                            //           ),
                            //           Text(
                            //             "Gallery",
                            //             style: TextStyle(
                            //                 fontSize: 13,
                            //                 color: Colors.grey[600]),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   margin: const EdgeInsets.symmetric(horizontal: 5),
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       primary: Colors.white,
                            //       onPrimary: Colors.grey,
                            //       shadowColor: Colors.grey[400],
                            //       elevation: 10,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(8.0)),
                            //     ),
                            //     onPressed: () {
                            //       // getImage();
                            //       // getImage(ImageSource.camera);
                            //     },
                            //     child: Container(
                            //       margin: const EdgeInsets.symmetric(
                            //           vertical: 5, horizontal: 5),
                            //       child: Column(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           Icon(
                            //             Icons.camera_alt,
                            //             size: 30,
                            //           ),
                            //           Text(
                            //             "Camera",
                            //             style: TextStyle(
                            //                 fontSize: 13,
                            //                 color: Colors.grey[600]),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // // Container(
                        // //   child: Text(finaltext),
                        // // )
                      ],
                    ),
                  ),
                )
              : isPrescription
                  ? Visibility(
                      child: Container(
                        color: Colors.white,
                        child: FutureBuilder(
                          // future: _initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final size = MediaQuery.of(context).size;
                              final deviceRatio = size.width / size.height;
                              return Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    height: 80.0,
                                    child: Center(
                                      child: Text(
                                        'Place a prescription in front of the camera',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Center(
                                            // child: _isLoading
                                            //     ? SizedBox()
                                            //     : CameraPreview(controller),
                                            ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child:
                                              // _isLoading
                                              // ?
                                              // Padding(
                                              //     padding: const EdgeInsets.all(20.0),
                                              //     child: CircularProgressIndicator(),
                                              //   )
                                              // :
                                              IconButton(
                                            icon: Icon(
                                              Icons.camera,
                                              color: Colors.white,
                                            ),
                                            iconSize: 70.0,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            onPressed: () async {
                                              // captureImage(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  : isProfile
                      ? Visibility(
                          child: Center(
                          child: Text("Profile page"),
                        ))
                      : Center(
                          child: Text("hello"),
                        ),
      // bottomNavigationBar: navBar(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              selectedIndex: 0,
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
                      isHome = true;
                      isScan = false;
                      isPrescription = false;
                      isProfile = false;
                      setState(() {});
                    }),
                GButton(
                    icon: Icons.document_scanner_outlined,
                    text: 'Scan',
                    onPressed: () {
                      isScan = true;
                      isHome = false;
                      isPrescription = false;
                      isProfile = false;
                      setState(() {});
                    }),
                GButton(
                    icon: Icons.library_books,
                    text: 'Prescription',
                    onPressed: () {
                      isPrescription = true;
                      isHome = false;
                      isScan = false;
                      isProfile = false;
                      setState(() {});
                    }),
                GButton(
                    icon: Icons.person,
                    text: 'Profile',
                    onPressed: () {
                      isProfile = true;
                      isHome = false;
                      isScan = false;
                      isPrescription = false;
                      setState(() {});
                    }),
              ]),
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(children: [
      Container(
        child: index.isEven
            ? Row(
                children: [
                  // Lottie.network(
                  //     "https://assets3.lottiefiles.com/packages/lf20_kaelaowc.json",
                  //     height: 200),
                  Lottie.asset('assets/animations/textRecognition.json',
                      height: 200),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          "Easily convert your",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Prescription",
                          style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "into Text",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 20, horizontal: 5),
                        //   child: SizedBox(
                        //     width: 145,
                        //     child: ElevatedButton(
                        //       onPressed: () {
                        //         getImage(ImageSource.camera);
                        //         // isScan = true;
                        //       },
                        //       style: TextButton.styleFrom(
                        //         // backgroundColor: Color(0xFF6CD8D1),
                        //         // elevation: 5,
                        //         backgroundColor: primaryColor,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           side: BorderSide(color: Colors.white),
                        //         ),
                        //       ),
                        //       child: Text("Try it now!!"),
                        //     ),
                        //   ),
                        // ),

                        // Text("made easy"),
                      ],
                    ),
                  ),

                  // Image.asset("assets/images/Asma_Khan.png"),
                ],
              )
            : Row(
                children: [
                  // Lottie.network(
                  //     "https://assets1.lottiefiles.com/packages/lf20_96cnyxkh.json",
                  //     height: 200),
                  Lottie.asset('assets/animations/security.json', height: 205),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          "All of your medical",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "information stays",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "SAFE",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.lightGreen,
                              ),
                            ),
                            Text(
                              " Here",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        //   child: SizedBox(
                        //     width: 145,
                        //     child: ElevatedButton(
                        //       onPressed: () {
                        //         getImage(ImageSource.camera);
                        //         // isScan = true;
                        //       },
                        //       style: TextButton.styleFrom(
                        //         // backgroundColor: Color(0xFF6CD8D1),
                        //         // elevation: 5,
                        //         backgroundColor: primaryColor,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           side: BorderSide(color: Colors.white),
                        //         ),
                        //       ),
                        //       child: Text("Try it now!!"),
                        //     ),
                        //   ),
                        // ),

                        // Text("made easy"),
                      ],
                    ),
                  ),

                  // Image.asset("assets/images/Asma_Khan.png"),
                ],
              ),
        height: 220,
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: primaryColor,
          color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9287cc),
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: AssetImage("images/slide1.jpg"),
          // ),
        ),
      ),
      // Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Container(
      //     height: 140,
      //     margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20),
      //         color: Colors.white,
      //         boxShadow: [
      //           BoxShadow(
      //             color: Color(0xFFe8e8e8),
      //             blurRadius: 7.0,
      //             offset: Offset(0, 5),
      //           ),
      //           BoxShadow(
      //             color: Colors.white,
      //             offset: Offset(-5, 0),
      //           ),
      //           BoxShadow(
      //             color: Colors.white,
      //             offset: Offset(5, 0),
      //           ),
      //         ]),
      //     child: Container(
      //       padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      //       child: Column(
      //         children: [
      //           Text(
      //             "Indoor Planters",
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           SizedBox(
      //             height: 2,
      //           ),
      //           Divider(
      //             thickness: 1,
      //             color: Colors.lightGreen,
      //           ),
      //           Text("Urban greens with 100% natural & organic plants"),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           OutlinedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const HomeScreen()),
      //               );
      //             },
      //             child: Text("Discover Now"),
      //             style: ButtonStyle(
      //                 foregroundColor: MaterialStateProperty.all(Colors.green)),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    ]);
  }
}
