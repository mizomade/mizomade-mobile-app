import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/widgets/SmallCard.dart';

class Related extends StatefulWidget {
  // const Related({Key key}) : super(key: key);
  final List relatedList;

  Related({this.relatedList});

  @override
  _RelatedState createState() => _RelatedState();
}

class _RelatedState extends State<Related> {
  @override
  void initState() {
    super.initState();
    print("Related" + widget.relatedList.toString().length.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.relatedList.toString().length >= 3) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: widget.relatedList.length,
          itemBuilder: (builder, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetail(
                            slug: widget.relatedList[index]['slug'])));
              },
              child: SmallCard(
                title: widget.relatedList[index]['title'],
                author: widget.relatedList[index]['author'],
                coverimage: widget.relatedList[index]['coverimage'],
                authorphoto: widget.relatedList[index]['authorphoto'],
                date: widget.relatedList[index]['date'],
              ),
            );
          });
    } else {
      return Container();
    }
  }
}
