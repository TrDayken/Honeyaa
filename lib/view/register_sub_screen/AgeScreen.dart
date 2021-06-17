import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeScreen extends StatefulWidget {
  final Function(num) onChanged;

  AgeScreen({@required this.onChanged});

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int age = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              Text(
                'age is',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              child: NumberPicker.integer(
                  listViewWidth: double.infinity,
                  textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  selectedTextStyle:
                      TextStyle(color: Colors.white, fontSize: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  initialValue: age,
                  minValue: 0,
                  maxValue: 120,
                  onChanged: (value) => {
                        setState(() {
                          age = value;
                        }),
                        widget.onChanged(value)
                      }),
            ),
          ),
        ),
      ],
    );
  }
}
