import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mizomade/screens/accounts/EditProfile.dart';
import 'package:mizomade/screens/accounts/Settings/SettingsPage.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/Network.dart';

import 'package:mizomade/widgets/SuggestionCards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Future postList;
  // String username = "";
  // String fullname = "";
  // String bio = "";
  // String coverphoto = "";
  // String profilephoto = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // void startingServices() async {
  //   getMyProfile();
  //   var prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString('username').toString();
  //     fullname =
  //         prefs.getString('first_name') + " " + prefs.getString('last_name');
  //     bio = prefs.getString('bio');
  //     coverphoto = prefs.getString('coverphoto');
  //     profilephoto = prefs.getString('profilephoto');
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      postList = getMyProfile();
    });
    // startingServices();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text("Profile"),
                  automaticallyImplyLeading: false,
                  foregroundColor: Theme.of(context).iconTheme.color,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        icon: Icon(Icons.settings_outlined))
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
              profile(context),
              Container(
                child: Text("Articles Body"),
              ),
            ])),
      ),
    );
  }

  Widget profile(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() {
        setState(() {
          postList = getMyProfile();
        });
      }),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              profileDetailsBlock(context),
              Divider(
                height: 20,
              ),
              usersPosts(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget profileDetailsBlock(BuildContext context) {
    return FutureBuilder(
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Image.network(snapshot.data[1]['coverphoto'],
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
              child: profileBlockLoading(context),
            );
        });
  }

  Widget profileBlockLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Column(
        children: [

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
            onPressed: () {},
            child: Text("Edit Profile"),
          ),
        ],
      ),
    );
  }

  Widget usersPosts(BuildContext context) {
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
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data[2].length,
                itemBuilder: (context, index) {
                  return snapshot.data[2][index]['published'] == true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetail(
                                          id: snapshot.data[2][index]['id']
                                              .toString(),
                                          slug: snapshot.data[2][index]['slug']
                                              .toString(),
                                        )));
                          },
                          // child: PostCard(
                          //   author: "Hmangaiha Pachuau",
                          //   date: "28 Dec 1994",
                          //   title: snapshot.data[index]['title'].toString(),
                          // ),
                          child: SuggestionCards(
                              title:
                                  snapshot.data[2][index]['title'].toString(),
                              date: snapshot.data[2][index]['date'].toString(),
                              coverImage: snapshot.data[2][index]['coverimage']
                                  .toString()),
                        )
                      : SizedBox();
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

  Widget usersDrafts(BuildContext context) {
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
        future: postList,
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
                    child: SuggestionCards(
                        title: snapshot.data[2][index]['title'].toString(),
                        date: snapshot.data[2][index]['date'].toString(),
                        coverImage:
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
