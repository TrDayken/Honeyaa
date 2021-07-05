import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:honeyaa_clientside/RouteHandler/Routing_Handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:honeyaa_clientside/notification/dependencyInjection.dart';
import 'package:honeyaa_clientside/notification/onesignal.dart';
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:flutter_infinite_list/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  oneSignalInitialize();
  injectionDependencies();
  // Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.getDeviceState().then((value) {
      print("DeviceStateL ${value?.jsonRepresentation()}");
    });
    return MaterialApp(
      title: 'Honeyaa!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: RouteHandler.generateRoute,
    );
  }
}
