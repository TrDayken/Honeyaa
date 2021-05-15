import 'package:flutter/material.dart';

class MainHub extends StatefulWidget 
{
    MainHub({Key key}) : super(key: key);

  @override
  _MainHubState createState() => _MainHubState() ; 

}

class _MainHubState extends State<MainHub> 
{
  @override
  Widget build( BuildContext context) 
  {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child:Scaffold(
      appBar: AppBar (
        automaticallyImplyLeading: false,
        title: Image.asset('assets/Honeyaa_logo.png', fit: BoxFit.cover),
        //leading: new IconButton(icon: Icon(Icons.switch_camera), onPressed:() {Navigator.pop(context);} ),        
        backgroundColor: Color.fromARGB(255, 255, 227, 143),
        bottom: TabBar(
          tabs: <Widget>
          [
            Tab( icon: Icon(Icons.switch_account)),
            Tab( icon: Icon(Icons.chat_bubble_rounded)),
            Tab( icon: Icon(Icons.person)),

          ]
        )
      )
    )
  );
}
}