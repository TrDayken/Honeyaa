import 'package:flutter/material.dart';

import 'package:honeyaa_clientside/networking/ApiProvider.dart';

class HobbyScreen extends StatefulWidget {
  final Function(List<String>) onChanged;

  HobbyScreen({@required this.onChanged});

  @override
  _HobbyScreenState createState() => _HobbyScreenState();
}

class _HobbyScreenState extends State<HobbyScreen> {
   bool _isChecked = false;
   bool _isChecked2 = false;
   bool _isChecked3 = false;
   bool _isChecked4 = false;

   List<String> result = [] ; 

   

  @override
  Widget build(BuildContext context) {

    print(result);

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
              if(value)
              {
                result.add(ApiProvider().baseUrl +"/interest/1/");
              }
              else 
              {
                result.remove(ApiProvider().baseUrl + "/interest/1/");
              }
                _isChecked = value;
              setState(() {
                widget.onChanged(result);
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
            value: _isChecked2,
            onChanged: (bool value) {
              if(value)
              {
                result.add(ApiProvider().baseUrl + "/interest/2/");
              }
              else 
              {
                result.remove(ApiProvider().baseUrl + "/interest/2/");
              }
                _isChecked2 = value;
              setState(() {
                widget.onChanged(result);
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
            value: _isChecked3,
            onChanged: (bool value) {
              if(value)
              {
                result.add(ApiProvider().baseUrl + "/interest/3/");
              }
              else 
              {
                result.remove(ApiProvider().baseUrl + "/interest/3/");
              }
                _isChecked3 = value;
              setState(() {
                widget.onChanged(result);
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
            value: _isChecked4,
            onChanged: (bool value) {
              if(value)
              {
                result.add(ApiProvider().baseUrl +"/interest/4/");
              }
              else 
              {
                result.remove(ApiProvider().baseUrl + "/interest/4/");
              }
                _isChecked4 = value;
              setState(() {
                widget.onChanged(result);
              });
            },
          ),
        )
      ],
    );
  }
}
