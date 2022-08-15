import 'package:flutter/material.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/welcome_screen.dart';

void main() {
  runApp(PharmChem());
}

class PharmChem extends StatelessWidget {
  const PharmChem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmChem - Prescription Reader App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: EdgeInsets.all(defaultPadding),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: textFieldBorder,
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
