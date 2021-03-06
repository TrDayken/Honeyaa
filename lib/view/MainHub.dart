import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:honeyaa_clientside/networking/ApiResponse.dart';
import 'package:honeyaa_clientside/notification/pushNotificationRepo.dart';
import 'package:honeyaa_clientside/view/LikeScreen.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/ProfileScreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../view/ChatHistoryView.dart';

class MainHub extends StatefulWidget {
  MainHub({Key key}) : super(key: key);

  @override
  _MainHubState createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {
  StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    final repo = Get.i.find<PushNotification>();
    _subscription = repo.onNotification.listen((notification){

    print("HOME PAGE");
    print("HOME PAGE:: ${notification.title}");
    });
  }

  @override
  void dispose(){
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titlepath = 'assets/Honeyaa_logo.png';

    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset(titlepath, fit: BoxFit.cover),
              //leading: new IconButton(icon: Icon(Icons.switch_camera), onPressed:() {Navigator.pop(context);} ),
              backgroundColor: Color.fromARGB(255, 255, 227, 143),
              bottom: TabBar(
                  indicatorColor: Color.fromARGB(255, 0, 0, 0),
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.switch_account)),
                    Tab(icon: Icon(Icons.star)),
                    Tab(icon: Icon(Icons.chat_bubble_rounded)),
                    Tab(icon: Icon(Icons.person)),
                  ])),
          body: TabBarView(
            children: [
              MyHomePage(),
              LikeScreen(),
              ChatHistory(),
              ProfileScreen(),
            ],
          ),
        ));
  }
}
