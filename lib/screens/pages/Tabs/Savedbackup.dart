
import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';


class SavedPosts extends StatefulWidget {
  // const SavedPosts({Key key}) : super(key: key);

  @override
  _SavedPostsState createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  Future postlist;

  @override
  void initState() {
    super.initState();
    postlist = bookmarkList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: FutureBuilder(
          future: postlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(slug:snapshot.data[index]['slug'],id:snapshot.data[index]['id'].toString())));
                      },
                      child: PostCard(
                        author: snapshot.data[index]['author'].toString(),
                        date: snapshot.data[index]['date'].toString(),
                        title: snapshot.data[index]['title'].toString(),
                        coverimage: HOST_URL + snapshot.data[index]['coverimage'].toString(),
                        authorimage: API_MEDIA_URL + snapshot.data[index]['authorphoto'].toString(),


                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error");
            } else
              return Center(
                  heightFactor: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                  ));
          },
        ));
  }
}
