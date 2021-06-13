import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honeyaa_clientside/auth/Methods.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

bool _obscureText = true;

class _RegisterScreenState extends State<RegisterScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: isLoading
            ? Center(
                child: Container(
                height: size.height / 15,
                width: size.width / 7,
                child: CircularProgressIndicator(),
              ))
            : Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register to Honeyaa and continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 28),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Enter your email and password below to continue to the Honeyaa and find your luv!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            border: Border.all(color: Colors.blue)),
                        child: TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              // prefix: Icon(icon),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            border: Border.all(color: Colors.blue)),
                        child: TextFormField(
                          controller: passwordController,
                          obscuringCharacter: '*',
                          obscureText: _obscureText,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              // prefix: Icon(icon),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });

                            createAccount(nameController.text,
                                    passwordController.text)
                                .then((user) {
                              if (user != null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MyHomePage()));
                                print("Account Created Sucessfull");
                              } else {
                                print("Login Failed");
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          } else {
                            print("Please enter Fields");
                          }
                        },
                        color: logoGreen,
                        child: Text('Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomCenter,
                      )
                    ],
                  ),
                ),
              ));
  }
}
