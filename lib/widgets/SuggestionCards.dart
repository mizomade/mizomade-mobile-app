import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/utils/API.dart';

class SuggestionCards extends StatelessWidget {
  // const SuggestionCards({Key key}) : super(key: key);

  final String title;
  final String user;
  final String date;
  final String category;
  final String coverImage;

  SuggestionCards(
      {this.title, this.user, this.date, this.category, this.coverImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: coverImage.toString() != "null"
                  ? Image.network(
                      coverImage,
                      width: 110,
                      height: 80,
                      fit: BoxFit.cover,
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
                  style: GoogleFonts.abel(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  maxLines: 3,
                ),
                Text(
                  dateFormat(date),
                  style: GoogleFonts.abel(),
                ),
              ],
            ),
          ),
          // IconButton(icon: Icon(Icons.bookmark), onPressed: (){})
        ],
      ),
    );
  }
}
