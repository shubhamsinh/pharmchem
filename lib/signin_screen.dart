import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmchem/components/signin_form.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/home_screen.dart';
import 'package:pharmchem/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  // const SignInScreen({super.key});
  bool hidePassword = true;

  bool hideCPassword = true;

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
            // Now it takes 100% of our height
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: Text(
                            "Sign Up!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "First Name",
                        // labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      controller: password,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        // hintText: "PASSWORD",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: Colors.black26,
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                        // labelText: "password",
                        // alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    // SignInForm(formKey: _formKey),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                          // if (_formKey.currentState!.validate()) {
                          //   // Sign up form is done
                          //   // It saved our inputs
                          //   _formKey.currentState!.save();
                          //   //  Sign in also done
                          // }
                        },
                        child: Text("Sign In"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
