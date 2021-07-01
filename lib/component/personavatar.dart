import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/models/User.dart';

import 'RoundIconButton.dart';

import 'package:honeyaa_clientside/bloc/userBloc.dart';

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

  getBloc() async {
    String id = await SharedPreferenceHelper().getUserId();

    userBloc.getUser(int.parse(id)); 
  }

  @override
  Widget build (BuildContext context) 
  {
    getBloc();

    return StreamBuilder(
      stream: userBloc.user,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return buildbutton(snapshot.data);
        }
        else if (snapshot.hasError) {
          return Text (snapshot.error.toString()); 
        }
        return Center (child: CircularProgressIndicator());
      },
    );
  }


  Widget buildbutton(User data) 
  {
        final String name = "Buckdie"; 
        final String age = "21";
        final birdavatarpath = 'assets/Bird_1.jpg';

        print(data); 
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