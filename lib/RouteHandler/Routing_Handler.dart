import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/auth/Authentication.dart';

import 'package:honeyaa_clientside/view/SplashScreen.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/ChatScreen.dart';
import 'package:honeyaa_clientside/view/MainHub.dart';
import 'package:honeyaa_clientside/view/LoginScreen.dart';

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
        return MaterialPageRoute(builder: (_) => MainHub());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => Authentication());
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
