import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/auth/Methods.dart';
import 'package:honeyaa_clientside/bloc/idBloc.dart';
import 'package:honeyaa_clientside/component/ProgressDialog.dart';
import 'package:honeyaa_clientside/models/OneSignal.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:honeyaa_clientside/view/MainHub.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/RegisterScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/RegisterSubScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool _obscureText = true;

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Colors.white;
  final Color secondaryColor = Color(0xffEB9605);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    //  set time to load the new page
    Future.delayed(Duration(seconds: 5), () {
      //Navigator.pushNamed(context, '/mainhub');
    });
    super.initState();
  }

  setUIDPref(String uid) async {
    await SharedPreferenceHelper().saveUserUID(uid);
  }

  setNamePref(String name) async {
    await SharedPreferenceHelper().saveUserName(name);
  }

  setAgePref(int age) async {
    await SharedPreferenceHelper().saveUserAge(age);
  }

  setOneSignalUID() async {
    var id = await SharedPreferenceHelper().getUserId();
    var userId = await OneSignal.shared.getDeviceState() ;

    OneSignalModel model = new OneSignalModel();

    model.oneSignalUID = userId.userId;
    model.owner = ApiProvider().baseUrl + "/person/" + id + "/";

    print(model.owner) ; 

    await ApiProvider().postOneSignalModel(model) ; 
  }

  setUserid(String uid) async {
    String id = await ApiProvider().getID(uid);

    print(id);

    await SharedPreferenceHelper().saveUserId(id);
  }

  validate(String uid) async {
    String id = await ApiProvider().getID(uid);

    print(id);
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: primaryColor,
        body: isLoading
            ? Center(
                child: Container(
                height: size.height / 5,
                width: size.height / 5,
                child: Lottie.asset('assets/lottie/honey-bee.json'),
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
                        'Sign in to Honeyaa and continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Enter your email and password below to continue to the Honeyaa and find your luv!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black),
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.black,
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
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: passwordController,
                          obscuringCharacter: '*',
                          obscureText: _obscureText,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              // prefix: Icon(icon),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });

                            logIn(nameController.text, passwordController.text)
                                .then((user) {
                              print(user.uid);
                              setUIDPref(user.uid);
                              setUserid(user.uid);

                              setOneSignalUID();
                              if (user != null) {
                                setState(() {
                                  //isLoading = true;
                                });
                                Navigator.pushNamed(context, "/mainhub");
                                print("Login Sucessfull");
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
                        color: secondaryColor,
                        child: Text('Login',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        color: Colors.blue,
                        child: Text('Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () {
                          signinWithGoogle().then((UserCredential value) {
                            final displayName = value.user.displayName;
                            final test = value.user.uid;
                            print(test);
                            var id = validate(test);

                            if (id == -1) {
                              setUIDPref(test);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterSubScreen()),
                                  (route) => false);
                            } else {
                              // setUIDPref(test);
                              // setUserid(id);

                              isLoading = true;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainHub()),
                                  (route) => false);
                            }
                          });
                        },
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google),
                            SizedBox(width: 10),
                            Text('Sign-in using Google',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomCenter,
                        //child: _buildFooterLogo(),
                      )
                    ],
                  ),
                ),
              ));
  }
}
