import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/ProfileScreen.dart';

import '../view/ChatHistoryView.dart';

class MainHub extends StatefulWidget {
  MainHub({Key key}) : super(key: key);

  @override
  _MainHubState createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {
  @override
  Widget build(BuildContext context) {
    final titlepath = 'assets/Honeyaa_logo.png';

    return DefaultTabController(
        initialIndex: 0,
        length: 3,
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
                    Tab(icon: Icon(Icons.chat_bubble_rounded)),
                    Tab(icon: Icon(Icons.person)),
                  ])),
          body: TabBarView(
            children: [
              MyHomePage(),
              ChatHistoryView(),
              ProfileScreen(),
            ],
          ),
        ));
  }
}
