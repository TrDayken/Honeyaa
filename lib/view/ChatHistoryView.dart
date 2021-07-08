import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';
import 'package:honeyaa_clientside/view/ChatScreen.dart';

class ChatHistory extends StatefulWidget {
  @override
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  final String myName = "Duy Dn";
  final String myUid = "7O9s2HZgDie8poYWFw0HuLtI4MC2";
  final String myUrl = "";

  final String name = "Cuong Do";
  final String uid = "lq9Phq7swkSSmPWqdf4dhy1k7qh1";
  final String url = "https://www.google.com/search?q=chelsea&sxsrf=ALeKk0142qKOTJDjCkeGZzpBw-t7FrmnLg:1624887793641&tbm=isch&source=iu&ictx=1&fir=EAH33eX_SrJJkM%252CBUoJQyBurJOB9M%252C%252Fm%252F023fb&vet=1&usg=AI4_-kSqVj31oTZeW0JtL_A2m5kM0KYzbg&sa=X&ved=2ahUKEwi_wvTdurrxAhW9wYsBHWs3ADoQ_B16BAgfEAI#imgrc=EAH33eX_SrJJkM";

  List<User> match = []; 

  void  getListMatched() async 
  {
    String id = await SharedPreferenceHelper().getUserId();

    User u = await ApiProvider().getUser(int.parse(id));

    await setNamePref(u.name);

    for (int i = 0 ; i < u.matchedPerson.length; i ++)
    {
      String matchid = u.matchedPerson[i].substring(u.matchedPerson[i].length-2, u.matchedPerson[i].length -1 ) ;
      User getinguser = await ApiProvider().getUser(int.parse(matchid));
      match.add(getinguser);
      if(getinguser != null) 
        setState(() {
          
        });
    }
  }

  setNamePref(String name) async {
    await SharedPreferenceHelper().saveDisplayName(name);
  }

  @override 
  void initState() 
  {
    getListMatched();

    super.initState();
  }


  @override
  Widget build(BuildContext context){

    return Column(
      // body: GestureDetector(
      //   onTap: () {
      //     Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ChatScreen(uid,name , url)));
      //   },
        children:  List.generate(match.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatScreen(match[index].uid, match[index].name, match[index].personpicture)));
            },
            child: chatcomponent(match[index].name, match[index].uid, match[index].personpicture));
        })
        
        // child: chatcomponent(name,uid,url),)
    );
  }

  Widget chatcomponent(String name, String uid, String url ){
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(8.0),
        //   child: Image(image: NetworkImage(url),fit: BoxFit.fill ,),
        // )
        backgroundImage: NetworkImage(url),
      ),
      title: Text(name),
      subtitle: Text('Wanna F*** birdie ?'),
    );
  }
}