import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override 
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new IconButton (
        icon: new Icon(
          Icons.arrow_back,
          color: Colors.grey,
          size: 40.0,
        ),
        onPressed: () {
          Navigator.pop(context);
          }
      )

      //actions: <Widget>[],

    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      // color: Colors.transparent,
      // elevation: 0.0,
      // child: new Padding( 
      //   padding: const EdgeInsets.all(16.0),
      //   child: new Icon(
      //     Icons.arrow_circle_down,
      //     color: Colors.grey,
      //     size: 40,
      //   )
      // ),
      // 
      // TODO: implement something else
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),

      // TODO: Implement chat bubble
      
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}