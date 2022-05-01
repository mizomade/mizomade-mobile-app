import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/screens/accounts/EditProfile.dart';
import 'package:mizomade/screens/accounts/Password/ForgotPassword.dart';
import 'package:mizomade/screens/accounts/Settings/SettingsPage.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:mizomade/widgets/Sidebar.dart';
import 'package:mizomade/widgets/SuggestionCards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

List<dynamic> posts;

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Future postlist;
  String username = "";
  String fullname = "";
  String bio = "";
  String coverphoto = "";
  String profilephoto = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _search = TextEditingController();

  void startingServices() async {
    getMyProfile();
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
      fullname =
          prefs.getString('first_name') + " " + prefs.getString('last_name');
      bio = prefs.getString('bio');
      coverphoto = prefs.getString('coverphoto');
      profilephoto = prefs.getString('profilephoto');
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      postlist = getMyProfile();

    });
    startingServices();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // child:
      // ListView(
      //   // mainAxisSize: MainAxisSize.min,
      //   shrinkWrap: true,
      //   children: <Widget>[
      //     Container(
      //       child: TabBar(
      //           labelColor: Colors.black54,
      //           indicatorColor: Colors.black87,
      //           tabs: [
      //             Tab(
      //               text: "My Profile",
      //             ),
      //             Tab(text: "Dashboard"),
      //           ]),
      //     ),
      //     Container(
      //       //Add this to give height
      //       height: MediaQuery.of(context).size.height,
      //       child: TabBarView(children: [
      //         Profile(context),
      //         Container(
      //           child: Text("Articles Body"),
      //         ),
      //       ]),
      //     ),
      //   ],
      // ),
      child: new Scaffold(
        body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text("Profile"),
                  automaticallyImplyLeading: false,
                  // backgroundColor: Theme.of(context).backgroundColor,
                  foregroundColor: Theme.of(context).iconTheme.color,
                  floating: true,
                  pinned: true,
                  snap: true,

                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));

                        }, icon: Icon(Icons.settings_outlined))
                  ],
                  bottom: new TabBar(
                      // labelColor: Colors.black54,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(
                          text: "My Profile",
                        ),
                        Tab(text: "Dashboard"),
                      ]),
                )
              ];
            },
            body: new TabBarView(children: [
              Profile(context),
              Container(
                child: Text("Articles Body"),
              ),
            ])),
      ),
    );
  }

  Widget Profile(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() { setState(() {
        postlist = getMyProfile();
      }); }),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ProfileBlock2(context),
              Divider(
                height: 20,
              ),

              UsersPosts(context)
              // Container(
              //   height: MediaQuery.of(context).size.height*0.88,
              //   child: FutureBuilder(
              //     future: postlist,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //             itemCount: snapshot.data.toString().length,
              //             itemBuilder: (context, index) {
              //               return GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) => PostDetail()));
              //                 },
              //                 child: PostCard(
              //                   author: "Hmangaiha Pachuau",
              //                   date: "28 Dec 1994",
              //                   title: snapshot.data[index]['title'].toString(),
              //                 ),
              //               );
              //             });
              //       } else if (snapshot.hasError) {
              //         return Text("Error");
              //       } else
              //         return Center(
              //             child: CircularProgressIndicator(
              //               backgroundColor: Colors.cyan,
              //             ));
              //     },
              //   ),
              // )

              // ...posts.map((item)=>Text(item)).toList()
              // getPostsWidgets(posts)
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileBlock2(BuildContext context) {
    return FutureBuilder(
        future: postlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                // Text(snapshot.data[1].toString()),
                Image.network(snapshot.data[1]['coverphoto'],
                    // HOST_URL + coverphoto,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 30, top: 30),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        child: ClipOval(
                            child: Image.network(
                          snapshot.data[1]['profilephoto'],
                          // HOST_URL + profilephoto,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data[0]['first_name'] +
                                " " +
                                snapshot.data[0]['last_name'],
                            // fullname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "@" + snapshot.data[0]['username'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "Posts",
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //     ),
                      //     Text("56",
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.grey)),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: Text(
                      "'" + snapshot.data[1]['bio'] + "'",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,

                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Text("Edit Profile"),
                ),
              ],
            );
          }
          // else if(snapshot.hasError){
          //   return Text("Error while loading");
          // }
          else
            return Center(
              child: ProfileBlockLoading(context),
            );
        });
  }

  Widget ProfileBlockLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Column(
        children: [
          // Text(snapshot.data[1].toString()),

          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 30, top: 30),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  child: ClipOval(
                      child: Container(
                    color: Colors.grey,

                    // HOST_URL + profilephoto,
                    width: 50,
                    height: 50,
                  )),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(1),
                      height: 24,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.all(1),
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 40,
                // ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.all(1),
                //       height: 30,
                //       width: 60,
                //       color: Colors.grey,
                //     ),
                //     // Text(
                //     //   "Posts",
                //     //   style: TextStyle(
                //     //       fontSize: 14,
                //     //       fontWeight: FontWeight.bold,
                //     //       color: Colors.grey),
                //     // ),
                //     Container(
                //       margin: EdgeInsets.all(1),
                //       height: 30,
                //       width: 30,
                //       color: Colors.grey,
                //     ),
                //     // Text("56",
                //     //     style: TextStyle(
                //     //         fontSize: 14,
                //     //         fontWeight: FontWeight.bold,
                //     //         color: Colors.grey)),
                //   ],
                // ),
              ],
            ),
          ),
          Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(bottom: 40),
                height: 20,
                width: MediaQuery.of(context).size.width * 0.68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 20,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ]),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => EditProfile()));
            },
            child: Text("Edit Profile"),
          ),
        ],
      ),
    );
  }

  Widget UsersPosts(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InputChip(
          // disabledColor: Colors.grey.shade300,
          disabledColor: Theme.of(context).disabledColor,

          avatar: Icon(Icons.loyalty_outlined),
          label: Text("Posts"),
        ),
      ),
      FutureBuilder(
        future: postlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data[2].length,
                itemBuilder: (context, index) {
                  return snapshot.data[2][index]['published'] == true ?
                 GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(id: snapshot.data[2][index]['id'].toString(),slug: snapshot.data[2][index]['slug'].toString(),)));
                      },
                      // child: PostCard(
                      //   author: "Hmangaiha Pachuau",
                      //   date: "28 Dec 1994",
                      //   title: snapshot.data[index]['title'].toString(),
                      // ),
                      child: SuggestionCards(
                          title: snapshot.data[2][index]['title'].toString(),
                          date: snapshot.data[2][index]['date'].toString(),
                          coverimage:
                              snapshot.data[2][index]['coverimage'].toString()),
                  )

                    : SizedBox() ;
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          } else
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.cyan,
            ));
        },
      ),
    ]);
  }

  Widget UsersDrafts(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: InputChip(
          disabledColor: Colors.grey.shade300,
          avatar: Icon(Icons.loyalty_outlined),
          label: Text("Posts"),
        ),
      ),
      FutureBuilder(
        future: postlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data[2].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetail()));
                    },
                    // child: PostCard(
                    //   author: "Hmangaiha Pachuau",
                    //   date: "28 Dec 1994",
                    //   title: snapshot.data[index]['title'].toString(),
                    // ),
                    child: SuggestionCards(
                        title: snapshot.data[2][index]['title'].toString(),
                        date: snapshot.data[2][index]['date'].toString(),
                        coverimage:
                        snapshot.data[2][index]['coverimage'].toString()),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          } else
            return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                ));
        },
      ),
    ]);
  }

}
