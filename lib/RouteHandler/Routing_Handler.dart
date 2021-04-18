import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/view/SplashScreen.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case 'mainscreen':
        return MaterialPageRoute(builder: (_) => MyHomePage());

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
