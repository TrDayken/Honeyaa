import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:geolocator/geolocator.dart';
import 'package:honeyaa_clientside/view/ProfileScreen.dart';

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

  @override
  void initState() {
    super.initState();
    setState(() {
      //itemTemp = explore_json;
      //itemLength = explore_json.lenght;
    });
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
                  // matchEngine.currentMatch.like();
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

  Widget getbody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          cardController: cardController,
          totalNum: 10,
          maxHeight: size.height * 0.7,
          maxWidth: size.width,
          minWidth: size.width * 0.75,
          minHeight: size.height * 0.5,
          cardBuilder: (context, index) => Container(
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
                              image: NetworkImage(
                                  'https://scontent-hkg4-2.xx.fbcdn.net/v/t31.18172-8/10841892_125844497760765_5091665117199786065_o.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ba80b0&_nc_ohc=dGiNk41WMpoAX_ymzGe&_nc_ht=scontent-hkg4-2.xx&oh=6a0cadfcc2c559b922f41ba3ad6c3135&oe=60F44D36'),
                              fit: BoxFit.cover)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //write code here
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
                                          border:
                                              Border.all(color: Colors.green)),
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
                                          border:
                                              Border.all(color: Colors.pink)),
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
                                              "Cuong",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
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
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                          color: Colors.white),
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
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    //print(_currentPosition);
    isSwipe = false;
    return Scaffold(
      body: getbody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
