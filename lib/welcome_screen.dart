import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/signin_screen.dart';
import 'package:pharmchem/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/splash_bg.svg"),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  // SvgPicture.asset(
                  //   "assets/images/Pharm-Chem_LOGO.jpeg",
                  // ),
                  Image.asset("assets/images/Pharm_Chem_LOGO.png", height: 300),
                  // Text(
                  //   "PharmChem",
                  //   style: TextStyle(
                  //       fontSize: 35,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //       letterSpacing: 2),
                  // ),
                  Spacer(),
                  // As you can see we need more paddind on our btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6CD8D1),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            )),
                        style: TextButton.styleFrom(
                          // backgroundColor: Color(0xFF6CD8D1),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF6CD8D1)),
                          ),
                        ),
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => SignUpScreen(),
                  //       ),
                  //     ),
                  //     style: TextButton.styleFrom(
                  //       backgroundColor: Colors.blue[850],
                  //     ),
                  //     child: Text("Signin with Google"),
                  //   ),
                  // ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
