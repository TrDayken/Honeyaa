import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/bloc/userBloc.dart';
import 'package:honeyaa_clientside/models/User.dart';

class ProfileEditScreen extends StatefulWidget {

  ProfileEditScreen({Key key}) :super(key: key);

  @override 
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
  
  
}

  class _ProfileEditScreenState extends State<ProfileEditScreen>{
    TextEditingController name = TextEditingController();

    
    Widget _buildAppBar()
    {
      final color = Colors.white;
      final buttonColor = Colors.grey;

      return AppBar (
        backgroundColor: color,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: buttonColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Widget _bodybuilder(User data)
    {
      data.name = 'ngocduy'; 
      return Column(children: [Text(data.name), Text(data.uid)]);
    }

    @override 
    Widget build (BuildContext context) {
      userBloc.getUser();

      return Scaffold(
        appBar: _buildAppBar(),
        body: StreamBuilder(
          stream: userBloc.user,
          builder: (context, AsyncSnapshot<User> snapshot) {
            if(snapshot.hasData) 
            {
              print(snapshot.data);
              return _bodybuilder(snapshot.data);
            }
            else if (snapshot.hasError) {
              return Text(snapshot.error.toString()); 
            }
            return Center (child: CircularProgressIndicator()); 
          },
        ),
      );
    }


}
