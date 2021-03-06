import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:geolocator/geolocator.dart';
import 'package:honeyaa_clientside/auth/HelperFunctions.dart';
import 'package:honeyaa_clientside/bloc/pictureBloc.dart';
import 'package:honeyaa_clientside/bloc/userBloc.dart';
import 'package:honeyaa_clientside/bloc/userListBloc.dart';
import 'package:honeyaa_clientside/models/Picture.dart';
import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';
import 'package:honeyaa_clientside/view/ProfileScreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../component//RoundIconButton.dart';
import 'package:honeyaa_clientside/auth/Methods.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List itemTemp = [];
  int itemLength = 0;
  bool isSwipe;
  CardController cardController = new CardController();
  Position _currentPosition;
  bool swipeDirection = false;
  bool fetched = false;

  int temp = 0;
  // bool processed = false;

  List<PictureBloc> pictures = [];
  List<bool> processed = [];
  List<String> urls = [];
  List<User> upondata = [];
  List<User> like = [];

  getBloc() async {
    String id = await SharedPreferenceHelper().getUserId();

    like = await ApiProvider().getLike(int.parse(id));

    print(like);

    listuserBloc.getListUser(int.parse(id));
  }

  createNotification(String uid, String personid) async {
    String id = await SharedPreferenceHelper().getUserId();
    
    var user = await ApiProvider().getUser(int.parse(id));

    user.matchedPerson.add(personid);

    await ApiProvider().putUser(user, id);

    var userId = await OneSignal.shared.getDeviceState() ; 

    var listids = await ApiProvider().getOneSignal(uid) ; 

    List<String> list = listids.map((e) => e.oneSignalUID).toList();
    print("[INFO]" + list.toString());

    list.add("${userId.userId}"); 
    print("[INFO]" + list.toString());

    var notification = OSCreateNotification(
      // playerIds: ["d0591ff0-3291-4768-b12c-154cd0bc94d9"],
      playerIds: list,
      content: "Check the app to find out who it was !!!",
      heading: "Someone has Matched with you",
    );
    var response = await OneSignal.shared.postNotification(notification);
    print(response.values);
  }
  createLikeNotification(String uid) async {
    var listids = await ApiProvider().getOneSignal(uid);

    var notification = OSCreateNotification(
      // playerIds: ["d0591ff0-3291-4768-b12c-154cd0bc94d9"],
      playerIds: listids.map((e) => e.oneSignalUID).toList(),
      content: "Keep right swip'in ",
      heading: "Someone Liked you",
    );

    var response = await OneSignal.shared.postNotification(notification);
    print(response.values);
  }

  @override
  void initState() {
    super.initState();

    getBloc();

    processed = List.filled(50, false);

    // setState(() {
    //   //itemTemp = explore_json;
    //   //itemLength = explore_json.lenght;
    // });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: new Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // new RoundIconButton.small(
              //   icon: Icons.refresh,
              //   iconColor: Colors.orange,
              //   onPressed: () {},
              // ),
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                onPressed: () {
                  cardController.triggerLeft();
                  swipeDirection = false;
                  isSwipe = true;
                  // temp ++ ;
                  // matchEngine.currentMatch.nope();
                },
              ),
              // new RoundIconButton.small(
              //   icon: Icons.star,
              //   iconColor: Colors.blue,
              //   onPressed: () {
              //     // matchEngine.currentMatch.superLike();
              //   },
              // ),
              new RoundIconButton.large(
                icon: Icons.favorite,
                iconColor: Colors.orange,
                onPressed: () {
                  cardController.triggerRight();
                  swipeDirection = true;
                  isSwipe = true;
                  pictureBloc.dispose();
                  // temp ++;
                  print(temp);

                  for (var x in like) {
                    if (upondata[temp] == x) {
                      createNotification(upondata[temp].uid, upondata[temp].url);
                      print("match !!!!!!!!!!!!!!!!");
                      return;
                    }
                    else 
                    {
                      createLikeNotification(upondata[temp].uid);
                      print ("Like !");
                      return;
                    }
                  }
                  // create Credential
                },
              ),
              // new RoundIconButton.small(
              //   icon: Icons.lock,
              //   iconColor: Colors.purple,
              //   onPressed: () {},
              // ),
            ],
          ),
        ));
  }

  Widget getbody(List<User> data) {
    upondata = data;

    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
            swipeCompleteCallback: (context, int index) {
              // temp = index;
              // setState(() {
              //   temp = index;
              // });
            },
            cardController: cardController,
            totalNum: data.length,
            maxHeight: size.height * 0.7,
            maxWidth: size.width,
            minWidth: size.width * 0.75,
            minHeight: size.height * 0.5,
            cardBuilder: (context, index) {
              temp = index;
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(urls[index]),
                                  fit: BoxFit.cover)),
                        ),
                        // StreamBuilder(
                        //   stream: pictures[index].picture,
                        //   builder: (context, AsyncSnapshot<String> snapshot) {
                        //       // final id = data[index].url[data[index].url.length -2];
                        //       // print (id) ;
                        //       // pictureBloc.getPicture(int.parse(id));
                        //     if (snapshot.hasData) {

                        //       // print(index);
                        //       // print(snapshot.data);

                        //       return buildPicture(snapshot.data);
                        //     } else if (snapshot.hasError) {
                        //       return Text(snapshot.error.toString());
                        //     }
                        //     return Center(child: CircularProgressIndicator());
                        //   },
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // pictureBloc.dispose();
                              },
                              child: Container(
                                //left
                                height: size.height * 0.7,
                                width: size.width * 0.4,
                                color: Colors.transparent,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  //write code here
                                },
                                child: Container(
                                  //right
                                  height: size.height * 0.7,
                                  width: size.width * 0.4,
                                  color: Colors.transparent,
                                ))
                          ],
                        ),
                        isSwipe
                            ? Row(
                                children: [
                                  swipeDirection
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green)),
                                          margin: new EdgeInsets.only(
                                              left: 30, top: 20),
                                          child: Text(
                                            "Like",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ))
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.pink)),
                                          margin: new EdgeInsets.only(
                                              left: 250, top: 20),
                                          child: Text(
                                            "Nope",
                                            style: TextStyle(
                                              color: Colors.pink,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))
                                ],
                              )
                            : Container(),
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.black.withOpacity(0.25),
                                Colors.black.withOpacity(0)
                              ],
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.72,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  data[index].name,
                                                  // "Cuong",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "21",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Recently Active",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                children: List.generate(
                                              //itemTemp[index]
                                              //['favorites'].length,
                                              //(index)
                                              3,
                                              (index) {
                                                //if(indexFavorites == 0){
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.white
                                                              .withOpacity(0.2),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 3,
                                                                top: 3),
                                                        child: Text(
                                                          //itemTemp
                                                          //[index]
                                                          //['favorites']
                                                          //[indexFavorites],
                                                          "Sport",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ));
                                                //}
                                                // return Padding(
                                                //     padding: const EdgeInsets.only(
                                                //         right: 8),
                                                //     child: Container(
                                                //       decoration: BoxDecoration(
                                                //           borderRadius:
                                                //               BorderRadius.circular(
                                                //                   30),
                                                //           color: Colors.white
                                                //               .withOpacity(0.4),
                                                //           border: Border.all(
                                                //               color: Colors.white,
                                                //               width: 2)),
                                                //       child: Padding(
                                                //         padding:
                                                //             const EdgeInsets.only(
                                                //                 left: 10,
                                                //                 right: 10,
                                                //                 bottom: 3,
                                                //                 top: 3),
                                                //         child: Text(
                                                //           //itemTemp
                                                //           //[index]
                                                //           //['favorites']
                                                //           //[indexFavorites],
                                                //           "Sport",
                                                //           style: TextStyle(
                                                //               color: Colors.white),
                                                //         ),
                                                //       ),
                                                //     ));
                                              },
                                            ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        width: size.width * 0.2,
                                        child: Center(
                                          child: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ))
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }

  Widget buildPicture(String data) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(data), fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    //print(_currentPosition);
    isSwipe = false;
    return Scaffold(
      body: StreamBuilder(
        stream: listuserBloc.listuser,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            if (fetched == false) {
              for (int i = 0; i < snapshot.data.length; i++) {
                final id =
                    snapshot.data[i].url[snapshot.data[i].url.length - 2];

                PictureBloc x = new PictureBloc();

                x.getPicture(int.parse(id));

                pictures.add(x);

                urls.add(snapshot.data[i].personpicture);
              }

              fetched = true;
            }

            return getbody(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
