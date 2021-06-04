import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RoundIconButton.dart';

class PersonAvatar extends StatefulWidget
{
  @override 
  _PersonAvatar createState() => _PersonAvatar();
}

class _PersonAvatar extends State<PersonAvatar>
{

  Widget buttonCarousel ()
  {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new RoundIconButton.large(
            icon: Icons.pending_outlined,
            onPressed: () {},
          ),
          // new RoundIconButton.large(
          //   icon: Icons.wifi_off,
          //   onPressed: () {}
          // ),
          new RoundIconButton.large(
            icon: Icons.person_sharp,
            onPressed: () {}
          ),
        ],
      )
    );
  }


  @override 
  Widget build(BuildContext context) 
  {
        final String name = "Buckdie"; 
        final String age = "21";
        final birdavatarpath = 'assets/Bird_1.jpg';

    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // user avatar
          ClipOval(
            child: Image.asset(birdavatarpath,
            width: 120,
            height: 120
            ,)
          ),

          //user name and age
          Text(
            name + ", " + age,
            style: TextStyle(fontSize: 22, fontFamily: 'GothamRounded', fontWeight: FontWeight.bold),
          ),

          Text(
            "Viet nam national university",
            style: TextStyle(fontSize: 15, fontFamily: 'GothamRounded', fontWeight: FontWeight.normal),
          ),
          buttonCarousel(),
        ],
      );
  }
}