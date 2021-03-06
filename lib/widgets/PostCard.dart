
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Texts.dart';

class PostCard extends StatefulWidget {
  // const PostCard({Key key}) : super(key: key);
  final String title;
  final String author;
  final String date;
  final String coverimage;
  final String authorimage;

  PostCard(
      {this.coverimage, this.title, this.authorimage, this.author, this.date});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
var titles ;


@override
void initState()
{
  super.initState();
  // final codeunits = ;
  titles =  convertingTitles(widget.title.codeUnits);
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.coverimage.toString() != "null"
              ? Image.network(
                  widget.coverimage,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                )
              : Container(),
          Container(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
                  mainAxisAlignment: MainAxisAlignment.start,
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      child: ClipOval(
// 45 before
                          child: widget.coverimage.toString() != "null" ?
                        Image.network(
                        S3_Host + widget.authorimage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ) : Container()),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   child: Text(
                        //     titles.toString(),
                        //     maxLines: 3,
                        //     softWrap: true,
                        //     style: GoogleFonts.playfairDisplay(
                        //       decoration: TextDecoration.none,
                        //       textStyle: TextStyle(
                        //           wordSpacing: 1,
                        //           letterSpacing: 1,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 16,
                        //           overflow: TextOverflow.ellipsis),
                        //     ),
                        //   ),
                        //   width: 280,
                        // ),
                        buildTitle(),
                        // RichText(text: TextSpan(text:''' widget.title ''')),
                        // Text(titles.toString()),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.author + " , ",
                              style: GoogleFonts.abel(
                                  fontSize: 14,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(DateFormat("dd MMM yyyy").format(DateTime.parse(widget.date)),
                                style: GoogleFonts.abel(
                                    fontSize: 12, letterSpacing: 2)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 26,
          ),

// Divider(height: 10,),
        ],
      ),
    );
  }

  Widget buildTitle() => Container(
    padding: EdgeInsets.only(top: 4),
    width: 280,
    child: Text.rich(TextSpan(
      text: titles,

            style: GoogleFonts.robotoCondensed(
              decoration: TextDecoration.none,
              textStyle: TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
            ),
      children: [
        // TextSpan(text:  "test????" )
      ]
    )),
  );
}
