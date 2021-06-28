import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatScreen(uid,name , url)));
        },
        child: chatcomponent(name,uid,url),)
    );
  }

  Widget chatcomponent(String name, String uid, String url ){
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        child: ClipOval(
          //child: Image(image: NetworkImage(url),fit: BoxFit.fill,),
        )
      ),
      title: Text(name),
      subtitle: Text('Wanna F*** birdie ?'),
    );
  }
}