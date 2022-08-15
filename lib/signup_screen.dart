import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/signin_screen.dart';

import 'components/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // const SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hideCPassword = true;

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            // height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            clipBehavior: Clip.hardEdge,
            // Now it takes 100% of our height
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              )),
                          child: Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    // SignUpForm(formKey: _formKey),
                    TextField(
                      controller: fname,
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
                      controller: lname,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Last Name",
                        // labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        // labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Mobile Number",
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
                    TextField(
                      controller: cpassword,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        // hintText: "PASSWORD",
                        labelText: "Confirm Password",
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

                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   // Sign up form is done
                          //   // It saved our inputs
                          //   _formKey.currentState!.save();
                          // }
                        },
                        child: Text("Sign Up"),
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
