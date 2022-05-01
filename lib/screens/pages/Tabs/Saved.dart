import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:mizomade/widgets/PostCardShimmer.dart';


class SavedPosts extends StatefulWidget {
  const SavedPosts({Key key}) : super(key: key);

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
    return FutureBuilder(

      future: postlist,
      builder: (context, snapshot) {
        if (snapshot.hasData ) {
          if(snapshot.data.length >= 1) {
            return RefreshIndicator(
                onRefresh: () => Future.sync(
                        () {
                      setState(() {
                        postlist = bookmarkList();

                      });

                    }),


                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,

                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetail(
                                          slug: snapshot.data[index]['slug'],
                                          id: snapshot.data[index]['id']
                                              .toString())));
                        },
                        child: PostCard(
                          author: snapshot.data[index]['author'].toString(),
                          date: snapshot.data[index]['date'].toString(),
                          title: snapshot.data[index]['title'].toString(),
                          coverimage: snapshot
                              .data[index]['coverimage'].toString(),
                          authorimage:  snapshot
                              .data[index]['authorphoto'].toString(),


                        ),
                      );
                  }),
                    ),
            );
          }
          else {
                    return Container(
                      height: MediaQuery.of(context).size.height*0.9,
                      child: RefreshIndicator(
                          onRefresh: () => Future.sync(
                                  () {
                                setState(() {
                                  postlist = bookmarkList();

                                });

                              }
                          ),

                              child: ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [Container
                              (
                                height: MediaQuery.of(context).size.height,
                                child: Center(child: Text("You currently does not have any saved post.")))]),
                      ),
                    );
          }
        }
        // else if(snapshot.data.length <= 0){
        //   return Container(child: FutureBuilder(
        //     future: postlist,
        //       builder: (context, snapshot) {
        //       }),
        //      );
        // }
        else if (snapshot.hasError) {
          return Text("Error");
        }
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
    );
  }
}
