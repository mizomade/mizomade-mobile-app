//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mizomade/utils/API.dart';
//
// class PostCard extends StatefulWidget {
//   // const PostCard({Key key}) : super(key: key);
//   String title;
//   String author;
//   String date;
//   String coverimage;
//   String authorimage;
//   PostCard({this.coverimage,this.title,this.authorimage,this.author,this.date});
//
//   @override
//   State<PostCard> createState() => _PostCardState();
// }
//
// class _PostCardState extends State<PostCard> {
//   String dateFormatted ;
//   String title;
//
//   void titeling()async{
//     title = widget.title;
//
//   }
//   @override
//   void initState(){
//     super.initState();
//     dateFormatted = DateFormat("dd MMM yyyy").format(DateTime.parse(widget.date));
//     setState(() {
//       title = widget.title;
//
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 400,
//       width: MediaQuery.of(context).size.width*0.8,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           widget.coverimage.toString() != "null"  ?  Image.network(widget.coverimage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: 230,):Container(),
//           Container(
//             // padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
//             padding: EdgeInsets.fromLTRB(12, 4, 12, 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children: [
//
//                 Text(widget.title,
//                   maxLines: 3,
//                   softWrap: true,
//
//                   style: GoogleFonts.oswald(
//                     decoration: TextDecoration.none,
//
//                     textStyle:TextStyle(wordSpacing: 1,letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 18,overflow: TextOverflow.ellipsis),),
//                 ),
//                 SizedBox(height: 8,),
//                 Flex(direction: Axis.horizontal,children: [
//                   Expanded(
//                     flex: 4,
//                     child: Row(
//                       children: [
//
//                         CircleAvatar(
//                           radius: 26,
//                           child: ClipOval(
// // 45 before
//                               child: Image.network(S3_Host+ widget.authorimage,width: 40,height: 40,fit: BoxFit.cover,)),
//                           backgroundColor: Colors.transparent,),
//                         SizedBox(width: 10,),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(widget.author,style: GoogleFonts.abel(fontSize: 14,letterSpacing: 2,fontWeight: FontWeight.w600),),
//                             Text(dateFormatted,style: GoogleFonts.abel(fontSize: 12,letterSpacing: 2)),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   // Expanded(
//                   //     flex: 1,
//                   //     child: IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_outline)))
//
//                 ],),
//
//
//               ],
//             ),
//           ),
//           SizedBox(height: 26,),
//
//
//
// // Divider(height: 10,),
//         ],
//       ),
//     );
//   }
// }
