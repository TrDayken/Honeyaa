import 'package:flutter/material.dart';

class NameScreen extends StatelessWidget {
  final Function(String) onChanged;
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  NameScreen({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'My first',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              Text(
                'name is',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white)),
          child: TextFormField(
            onChanged: onChanged,
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
