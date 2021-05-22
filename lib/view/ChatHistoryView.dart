import 'package:flutter/material.dart';
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
        Text('Anonymous Chat'),
        ChatPersonTile(),
        Text('Message'),
        ChatPersonTile(),
        ChatPersonTile(),
      ],
    );
  }
}