import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/view/LoginScreen.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';

class Authentication extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return MyHomePage();
    } else {
      return LoginScreen();
    }
  }
}
