import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPersonTile extends StatefulWidget 
{
  @override 
  _ChatPersonTile createState() => _ChatPersonTile();
}

class _ChatPersonTile extends State<ChatPersonTile>
{
  @override 
  Widget build(BuildContext context) 
  {
    final double avatarradious = 40; 
    
    final birdavatarpath = 'assets/Bird_1.jpg';
    final birdiename ='Horny Bird near your area!!!';

    return ListTile(
      leading: CircleAvatar(
        radius: avatarradious,
        //backgroundImage: Image.asset(birdavatarpath, BoxFit.cover),
        child: ClipOval(
          child: Image.asset(birdavatarpath, fit: BoxFit.fill) ,
          //borderRadius: BorderRadius.circular(100.0),
        )
      ),
      title: Text(birdiename),
      subtitle: Text('Wanna F*** birdie ?'),
      
    );
  }
}