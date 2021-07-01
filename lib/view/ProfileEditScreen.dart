import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/bloc/userBloc.dart';
import 'package:honeyaa_clientside/models/User.dart';

class ProfileEditScreen extends StatefulWidget {

  ProfileEditScreen({Key key}) :super(key: key);

  @override 
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
  
  
}

  class _ProfileEditScreenState extends State<ProfileEditScreen>{
    TextEditingController name = TextEditingController();
    TextEditingController age = TextEditingController();

    
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
      return ListView(
        children:<Widget> [
          Padding(
            padding: EdgeInsets.all(12.0) , 
            child:  Text('Your name:')
          ),
          ListTile(
            title: TextField(
              controller: name..text = data.name
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Age:'),
          ),
          ListTile(
            title: TextField(
              controller: age..text = data.url,
            ),
          )
        ],
      );
    }

    getBloc() async {
      String id = await SharedPreferenceHelper().getUserId();

      userBloc.getUser(int.parse(id));
    }

    @override 
    Widget build (BuildContext context) {

      getBloc();

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
