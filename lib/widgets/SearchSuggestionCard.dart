import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/pages/PostDetail.dart';
import '../utils/API.dart';

Widget SearchSuggestionCards(BuildContext context, String id,String title, String date,
    String author, String image,String slug) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetail(id:id, slug: slug,)));

    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image != 'null'? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                width: 110,
                height: 90,
                fit: BoxFit.cover,
              )):SizedBox(width: 110,height: 90,),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 80,
                //   decoration: BoxDecoration(
                //     color: Colors.green[300],
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: Center(child: Text("EISIAM",style: TextStyle(color:Colors.white),)),),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
                Text("@"+author,style: GoogleFonts.abel(),),

                Text(dateFormat(date),style: GoogleFonts.abel(),),
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