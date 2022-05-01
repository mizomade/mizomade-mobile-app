import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/utils/API.dart';

class SmallCard extends StatelessWidget {
  // const SmallCard({Key key}) : super(key: key);
  String author;
  String title;
  String coverimage;
  String authorphoto;
  String date;

  SmallCard(
      {this.author, this.title, this.coverimage, this.authorphoto, this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            this.coverimage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.network(
                      this.coverimage,
                      fit: BoxFit.cover,
                      height: 180,
                      width: 230,
                    ))
                : Container(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
                child: Text(
                  this.title,
                  style: GoogleFonts.abel(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  ),
                  maxLines: 3,
                )),
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  child: ClipOval(
                      child: Image.network(
                    S3_Host + this.authorphoto,
                    width: 35,
                    height: 35,
                    fit: BoxFit.fill,
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
                      this.author,
                      style: GoogleFonts.abel(),
                    ),
                    Text(
                      dateFormat(this.date),
                      style: GoogleFonts.abel(),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
