import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:mizomade/widgets/PostCardShimmer.dart';

class TagPage extends StatefulWidget {
  // const SavedPosts({Key key}) : super(key: key);
  String tag;

  TagPage({this.tag});

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  Future postlist;

  @override
  void initState() {
    super.initState();
    getlisting();
  }

  Future<void> getlisting() async {
    setState(() {
      postlist = tagList(widget.tag.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(children: [
          Text("Tags"),
          InputChip(
              disabledColor: Colors.grey.shade200,
              label: Text(
                "#" + widget.tag.toString(),
              ))
        ]),
      ),
      body: FutureBuilder(
        future: postlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: getlisting,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(
                                    slug: snapshot.data[index]['slug'],
                                    id: snapshot.data[index]['id']
                                        .toString())));
                      },
                      child: PostCard(
                        author: snapshot.data[index]['author'].toString(),
                        date: snapshot.data[index]['date'].toString(),
                        title: snapshot.data[index]['title'].toString(),
                        coverimage:
                            snapshot.data[index]['coverimage'].toString(),
                        authorimage:
                            snapshot.data[index]['authorphoto'].toString(),
                      ),
                    );
                  }),
            );
          }
          // else if (snapshot.hasError) {
          //   return Text("Error");
          // }
          else
            return SingleChildScrollView(
              child: Column(
                children: [
                  PostCardShimmer(),
                  PostCardShimmer(),
                  PostCardShimmer(),
                ],
              ),
            );
        },
      ),
    );
  }
}
