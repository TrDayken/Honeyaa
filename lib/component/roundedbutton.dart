import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget
{
  @override 
  Widget build  (BuildContext context)
  {
    return ElevatedButton(
      onPressed: () {},
      child: Text('button', 
      style: TextStyle(
        color: Colors.black ,
        fontFamily: 'GothamRounded',
        fontWeight: FontWeight.bold
        ),
        ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
    );
  }
}