import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override 
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new IconButton (
        icon: new Icon(
          Icons.arrow_back,
          color: Colors.grey,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.pop(context);
          }
      ),

      actions: <Widget>[
        new IconButton(
          icon : new Icon( 
            Icons.shield,
            color: Colors.blue,
            size: 30.0,
          ),
        onPressed: (){
          //TODO: implement block/ unblock
        },
        )
      ],

    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      // color: Colors.blue,
      // elevation: 0.0,
      // child: new Padding( 
      //   padding: const EdgeInsets.all(16.0),
      //   child: new Icon(
      //     Icons.arrow_circle_down,
      //     color: Colors.grey,
      //     size: 40,
      //   )
      // ),
      // 
      // TODO: implement something else
    );
  }

  @override 
  Widget build(BuildContext context) {
    bool isSenderChatBubble = true ; 
    return Scaffold(
      appBar: _buildAppBar(),
      // TODO: Implement chat bubble
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 160, 20, 177),
                  Color.fromARGB(255, 194, 142, 20)
                ]
              )
            )
          ),

          Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (BuildContext context,
                BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints (
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        //child: Column(children: _multicolorbubbles(),)
                        )
                      ),
                  );
                }
                ),  
              )
          ),
          
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.white, isSenderChatBubble ? BlendMode.dstATop : BlendMode.srcOut), //config isSendersChatBubble
            child: Container(
              alignment: isSenderChatBubble ? Alignment.centerLeft :Alignment.centerRight, // config ismine?
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: isSenderChatBubble //config isSendersChatBubble
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                                
                                child: isSenderChatBubble //config isSendersChatBubble
                                ? Row(children: [
                                  Center(
                                    child: Container(
                                      constraints: BoxConstraints(maxWidth: 250, minWidth: 55),
                                      padding: EdgeInsets.fromLTRB(15,20,15,3),
                                      child: Text("okay", style: TextStyle(
                                        color: Colors.transparent,
                                      ))
                                    )
                                  )
                                ],
                              )
                              : Center(
                                child: Container(
                                constraints: BoxConstraints(maxWidth: 250,),
                                padding: EdgeInsets.fromLTRB(15,20,15,3),
                                child: Text("hello?", style: TextStyle(
                                  color: Colors.transparent),
                                             
                                ),
                                )),
                              margin: EdgeInsets.only(top: 10, right: 20, left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey.withOpacity(0.9),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                )
              ],
            )
            ),
          )
        ],
      ),

      bottomNavigationBar: _buildBottomBar(),
    );
  }
}