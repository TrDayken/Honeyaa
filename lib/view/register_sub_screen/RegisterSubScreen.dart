import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/component/custom_modal_progress_hud.dart';
import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/models/UserRegistration.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';
import 'package:honeyaa_clientside/view/MainScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/AddPhotoScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/AgeScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/GenderScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/HobbyScreen.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/NameScreen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RegisterSubScreen extends StatefulWidget {
  @override
  _RegisterSubScreenState createState() => _RegisterSubScreenState();
}

const kDefaultPadding = EdgeInsets.symmetric(
  vertical: 36.0,
  horizontal: 26.0,
);

class _RegisterSubScreenState extends State<RegisterSubScreen> {
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _endScreenIndex = 4;
  int _currentScreenIndex = 0;
  final UserRegistration _userRegistration = UserRegistration();
  final Color primaryColor = Colors.white;
  final Color secondaryColor = Color(0xffEB9605);

  void goBackPressed() {
    if (_currentScreenIndex == 0) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    } else {
      setState(() {
        _currentScreenIndex--;
      });
    }
  }

  void showSnackBar(GlobalKey<ScaffoldState> globalKey, String message) {
    final snackBar = SnackBar(content: Text(message));
    globalKey.currentState.hideCurrentSnackBar();
    globalKey.currentState.showSnackBar(snackBar);
  }

  bool canContinueToNextSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return (_userRegistration.name.length >= 2);
      case 1:
        return (_userRegistration.age >= 13 && _userRegistration.age <= 120);
      case 2:
        return _userRegistration.localProfilePhotoPath.isNotEmpty;
      case 3:
        return _userRegistration.gender.isNotEmpty;
      default:
        return false;
    }
  }

  String getInvalidRegistrationMessage() {
    switch (_currentScreenIndex) {
      case 0:
        return "Name is too short";
      case 1:
        return "Invalid age";
      case 2:
        return "Invalid photo";
      default:
        return "";
    }
  }

  // void registerUser() async {
  // setState(() {
  //   isLoading = true;
  // });

  // await _userProvider
  //     .registerUser(_userRegistration, _scaffoldKey)
  //     .then((response) {
  //   if (response is Success) {
  //     Navigator.pop(context);
  //     Navigator.pushNamed(context, TopNavigationScreen.id);
  //   }
  // });

  Widget getSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return NameScreen(
            onChanged: (value) => {_userRegistration.name = value});
      case 1:
        return AgeScreen(onChanged: (value) => {_userRegistration.age = value});
      case 2:
        return AddPhotoScreen(
            onPhotoChanged: (value) =>
                {_userRegistration.localProfilePhotoPath = value});
      case 3:
        return GenderScreen(
          onChanged: (value) => {_userRegistration.gender = value},
        );
      case 4:
        return HobbyScreen(
          onChanged: (value) => {_userRegistration.hobby = value},
        );
      default:
        return Container();
    }
  }

   createUser(UserRegistration user) async {
     String uid = await SharedPreferenceHelper().getUserUID(); 

     User postmodel = User.fromUserRegistration(user);
     postmodel.uid = uid; 

     print (postmodel) ;
     return await ApiProvider().postUser(postmodel);
   }
   
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomInset: false,
        //key: _scaffoldKey,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Register',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          backgroundColor: secondaryColor,
        ),
        body: CustomModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Container(
                  child: LinearPercentIndicator(
                      lineHeight: 5,
                      percent: (_currentScreenIndex / _endScreenIndex),
                      progressColor: Colors.blue,
                      padding: EdgeInsets.zero),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: kDefaultPadding.copyWith(
                          left: kDefaultPadding.left / 2.0,
                          right: 0.0,
                          bottom: 4.0,
                          top: 4.0),
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          _currentScreenIndex == 0
                              ? Icons.clear
                              : Icons.arrow_back,
                          color: Colors.white,
                          size: 42.0,
                        ),
                        onPressed: () {
                          goBackPressed();
                        },
                      )),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      child: getSubScreen(),
                      padding: kDefaultPadding.copyWith(top: 0, bottom: 0)),
                ),
                Container(
                  padding: kDefaultPadding,
                  child: _currentScreenIndex == (_endScreenIndex)
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          minWidth: size.width,
                          height: size.height / 15,
                          child: Text('Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          textColor: Colors.white,
                          color: secondaryColor,
                          onPressed: isLoading == false
                              ? () => {
                                    createUser(_userRegistration),
                                    Navigator.pushNamed(context, "/mainhub")
                                  }
                              : null)
                      : MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          minWidth: size.width,
                          height: size.height / 15,
                          child: Text('Continue',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          textColor: Colors.white,
                          color: secondaryColor,
                          onPressed: () => {
                            if (canContinueToNextSubScreen())
                              setState(() {
                                _currentScreenIndex++;
                              })
                            else
                              showSnackBar(
                                  _scaffoldKey, getInvalidRegistrationMessage())
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
