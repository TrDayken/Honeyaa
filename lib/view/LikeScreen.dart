import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    print("you are at like screen");
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.only(bottom: 90),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "10 Likes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                  //like_json.length , (index)
                  1, (index) {
                return Container(
                  width: (size.width - 15) / 2,
                  height: 250,
                  child: Stack(
                    children: [
                      Container(
                        width: (size.width - 15) / 2,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://scontent-hkg4-2.xx.fbcdn.net/v/t31.18172-8/10841892_125844497760765_5091665117199786065_o.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ba80b0&_nc_ohc=dGiNk41WMpoAX_ymzGe&_nc_ht=scontent-hkg4-2.xx&oh=6a0cadfcc2c559b922f41ba3ad6c3135&oe=60F44D36'
                                    //ike_json[index]['img]
                                    ),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: (size.width - 15) / 2,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Colors.black.withOpacity(0.25),
                              Colors.black.withOpacity(0),
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //like_json[index]['active] ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Recently Active',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                            //:
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         width: 8,
                            //         height: 8,
                            //         decoration: BoxDecoration(
                            //             color: Colors.grey,
                            //             shape: BoxShape.circle),
                            //       ),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(
                            //         'Offline',
                            //         style: TextStyle(
                            //             fontSize: 14, color: Colors.white),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })),
        )
      ],
    );
  }
}
