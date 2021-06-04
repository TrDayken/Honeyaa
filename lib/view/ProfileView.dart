import 'package:flutter/material.dart';

import '../component/personavatar.dart';
import '../component/RoundIconButton.dart'; 

class ProfileView extends StatefulWidget{
  @override
  _ProfileViewState createState() => _ProfileViewState(); 
}

class _ProfileViewState extends State<ProfileView>{

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: PersonAvatar(),
                )
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Color.fromARGB(25, 138, 138, 138),
                ),
              )
          ],
          )
        ],
      )
    );
  }
} 