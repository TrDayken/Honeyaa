import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/RouteHandler/Routing_Handler.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_infinite_list/simple_bloc_observer.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honeyaa!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/mainhub',
      onGenerateRoute: RouteHandler.generateRoute,
    );
  }
}
