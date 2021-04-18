import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //  set time to load the new page
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushNamed(context, 'mainscreen');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/honey-bee.json'),
      ),
    );
  }
}
