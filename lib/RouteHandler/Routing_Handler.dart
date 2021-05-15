import 'package:flutter/material.dart';

import 'package:honeyaa_clientside/view/SplashScreen.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/ChatScreen.dart';
import 'package:honeyaa_clientside/view/MainHub.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/mainscreen':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/chatscreen':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/mainhub':
        return MaterialPageRoute(builder: (_) => MainHub()) ; 
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
