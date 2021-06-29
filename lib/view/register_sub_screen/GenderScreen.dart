import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenderScreen extends StatefulWidget {
  final Function(String) onChanged;

  GenderScreen({@required this.onChanged});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  int age = 0;
  final Color primaryColor = Colors.white;
  final Color secondaryColor = Color(0xffEB9605);
  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
    'gay': 'Gay',
    'less':'Less'
  };
  String _selectedGender = genderMap.keys.first;

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
                'You are',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              child: CupertinoRadioChoice(
              choices: genderMap,
              onChange: (value) => {
                setState(() {
                          _selectedGender = value;
                        }),
                        widget.onChanged(value)
              },
              initialKeyValue: _selectedGender),
            ),
          ),
        ),
      ],
    );
  }
}
