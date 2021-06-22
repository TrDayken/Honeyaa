import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/bloc/userBloc.dart';
import '../component/chatpersontile.dart';

class ChatHistoryView extends StatefulWidget{
  @override
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistoryView> 
{
  final firstheadingtext = 'Anonymous Message';
  final secondheadingtext = 'Message';

  @override
  Widget build (BuildContext context) 
  {
    return ListView(
      children: <Widget> [
        //anonymous heading
        Padding(
          padding: EdgeInsets.all(12.0) , 
          child:  Text('Anonymous Chat')
          ),
          //this will be a list of future person 
        ChatPersonTile(),
        // Mesage heading
        Padding( 
          padding: EdgeInsets.all(12.0),
          child:  Text('Message')
          ),
          // this will be a list of future person
        ChatPersonTile(),
        ChatPersonTile(),
      ],
    );
  }
}