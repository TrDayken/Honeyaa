import 'package:flutter/material.dart';

class HobbyScreen extends StatefulWidget {
  final Function(num) onChanged;

  HobbyScreen({@required this.onChanged});

  @override
  _HobbyScreenState createState() => _HobbyScreenState();
}

class _HobbyScreenState extends State<HobbyScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your",
          style: TextStyle(
              color: Colors.black, fontSize: 50, fontWeight: FontWeight.w500),
        ),
        Text(
          "hobbies..!",
          style: TextStyle(
              color: Colors.black, fontSize: 50, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black)),
          child: CheckboxListTile(
            selectedTileColor: Colors.black,
            title: const Text(
              'Sleep',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            secondary: const Icon(
              Icons.bed,
              color: Colors.black,
              size: 25,
            ),
            value: _isChecked,
            onChanged: (bool value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black)),
          child: CheckboxListTile(
            selectedTileColor: Colors.black,
            title: const Text(
              'Music',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            secondary: const Icon(
              Icons.music_note,
              color: Colors.black,
              size: 25,
            ),
            value: _isChecked,
            onChanged: (bool value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black)),
          child: CheckboxListTile(
            selectedTileColor: Colors.black,
            title: const Text(
              'Sport',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            secondary: const Icon(
              Icons.sports,
              color: Colors.black,
              size: 25,
            ),
            value: _isChecked,
            onChanged: (bool value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black)),
          child: CheckboxListTile(
            selectedTileColor: Colors.black,
            title: const Text(
              'Travel',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            secondary: const Icon(
              Icons.travel_explore,
              color: Colors.black,
              size: 25,
            ),
            value: _isChecked,
            onChanged: (bool value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        )
      ],
    );
  }
}
