import 'package:flutter/material.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';

import 'PostDetail.dart';

class UserPage extends StatefulWidget {
  // const UserPage({Key key}) : super(key: key);
  String username;

  UserPage({this.username});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  ScrollController _scrollController;
  Future userDetails;

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    userDetails = userDetail(widget.username);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      _scrollListener();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: userDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,

                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      expandedHeight: 200,
                      centerTitle: false,
                      // leadingWidth: 0,
                      foregroundColor:
                          Theme.of(context).appBarTheme.foregroundColor,
                      automaticallyImplyLeading: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          '@' + snapshot.data[0]['username'],
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: isShrink ? Colors.black : Colors.white,
                              fontSize: 16),
                        ),
                        background: Image.network(
                          snapshot.data[1]['coverphoto'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 30, top: 30),
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              child: ClipOval(
                                  child: Image.network(
                                snapshot.data[1]['profilephoto'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )),
                              backgroundColor: Colors.transparent,
                            ),
                            Text(
                              snapshot.data[0]['first_name'] +
                                  " " +
                                  snapshot.data[0]['last_name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text("56",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                              ],
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
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: InputChip(
                          avatar: Icon(Icons.loyalty_outlined),
                          disabledColor: Colors.grey.shade200,
                          label: Text("Posts"),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data[2].length,
                          itemBuilder: (context, index) {
                            return SugeestionCards(
                                snapshot.data[2][index]['id'].toString(),
                                snapshot.data[2][index]['title'].toString(),
                                snapshot.data[2][index]['date'].toString(),
                                snapshot.data[2][index]['coverimage']
                                    .toString(),
                                snapshot.data[2][index]['slug'].toString());
                          }),
                      Divider(),
                      Container(color: Colors.black54, height: 50.0),
                    ])),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error while fetching data");
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
  }

  Widget SugeestionCards(
      String id, String title, String date, String coverimage, String slug) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostDetail(
                      id: id,
                      slug: slug,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: coverimage != 'null'
                    ? Image.network(
                        coverimage,
                        width: 110,
                        height: 80,
                        fit: BoxFit.fill,
                      )
                    : SizedBox(
                        width: 110,
                        height: 80,
                      )),
            Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(dateFormat(date)),
                  // InputChip(
                  //
                  //   label: Text("Gospel",),),
                ],
              ),
            ),
            // IconButton(icon: Icon(Icons.bookmark), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
