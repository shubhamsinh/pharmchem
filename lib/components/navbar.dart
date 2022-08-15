import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/home_screen.dart';
import 'package:pharmchem/scanning_screen.dart';

class navBar extends StatelessWidget {
  const navBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }),
              GButton(
                  icon: Icons.document_scanner_outlined,
                  text: 'Scan',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanScreen()));
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
    ));
  }
}
