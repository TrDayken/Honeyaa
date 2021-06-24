import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/bloc/pictureBloc.dart';
import 'package:honeyaa_clientside/view/register_sub_screen/RegisterSubScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getBody(),
        Container(
          height: 45,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget buildPicture (String data)
  {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(data),
          fit: BoxFit.cover
         ),
      ),
    );
  }



  Widget getBody() {
    var size = MediaQuery.of(context).size;

    pictureBloc.getPicture();
    return Container(
      width: size.width * 2,
      height: size.height * 0.55,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
              stream: pictureBloc.picture,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if(snapshot.hasData)
                {
                  print(snapshot.data);
                  return buildPicture(snapshot.data);
                }
                else if(snapshot.hasError) {
                  return Text (snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            // Container(
            //   width: 140,
            //   height: 140,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       image: DecorationImage(
            //           image: NetworkImage(
            //               "https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/157314952_292205995579537_3091515640804872056_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=0debeb&_nc_ohc=66YXWn73VUEAX-CrZuR&_nc_ht=scontent-hkg4-1.xx&oh=813c2fee49ac47db469c6f3ea513065e&oe=60D545F3"),
            //           fit: BoxFit.cover)),
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Duy, 25",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          {Navigator.pushNamed(context, '/profileEdit')},
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 15,
                                // changes position of shadow
                              ),
                            ]),
                        child: Icon(
                          Icons.settings,
                          size: 35,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.withOpacity(0.8)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 85,
                          height: 85,
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFfc3973),
                                        Color(0xFFfd5f60)
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        // changes position of shadow
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 10,
                                          blurRadius: 15,
                                          // changes position of shadow
                                        ),
                                      ]),
                                  child: Center(
                                    child: Icon(Icons.add,
                                        color: Color(0xFFFD5C61)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add Media",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RegisterSubScreen()))
                            },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 15,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Icon(
                            Icons.edit,
                            size: 35,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.withOpacity(0.8)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
