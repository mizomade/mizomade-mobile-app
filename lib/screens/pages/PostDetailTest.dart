// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:mizomade/screens/pages/RelatedPost/Related.dart';
// import 'package:mizomade/screens/pages/UserPage.dart';
// import 'package:http/http.dart' as http;
// import 'package:mizomade/utils/API.dart';
// import 'package:mizomade/utils/Network.dart';
//
// import 'Comment/CommentList.dart';
// import 'TagPage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
//
// class PostDetailTest extends StatefulWidget {
//   // const PostDetail({Key? key}) : super(key: key);
//   String slug;
//   String id;
//
//   PostDetailTest({this.slug, this.id});
//
//   @override
//   _PostDetailTestState createState() => _PostDetailTestState();
// }
//
// class _PostDetailTestState extends State<PostDetailTest> {
//   var tags;
//   bool likeStatus;
//   bool bookmarkStatus;
//   final FocusNode _focusNode = FocusNode();
//   // QuillEditor quill ;
//
//   // QuillController _controller = QuillController.basic();
//
//   // Future fetchDetail(String slug) async {
//   //   print("INITTTT");
//   //   var response = await http.get(Uri.parse(API_URL + 'posts/' + slug));
//   //   print("RESPONES" + json.decode(response.body).toString());
//   //
//   //   if (response.statusCode == 200) {
//   //
//   //     print("True");
//   //     tags = jsonDecode(response.body)['post']['tags'];
//   //     return jsonDecode(response.body);
//   //   } else {
//   //     print("Error");
//   //   }
//   // }
//
//   void checkInitialStatus() async {
//     var likeResult = await checkLikeStatus(widget.id.toString());
//     if (likeResult == 1) {
//       setState(() {
//         likeStatus = true;
//       });
//     } else if (likeResult == 0) {
//       setState(() {
//         likeStatus = false;
//       });
//     }
//     var bookmarkResult = await checkBookmarkStatus(widget.id.toString());
//     if (bookmarkResult == 1) {
//       setState(() {
//         bookmarkStatus = true;
//       });
//     } else if (bookmarkResult == 0) {
//       setState(() {
//         bookmarkStatus = false;
//       });
//     }
//   }
//   QuillController contentController = new QuillController();
//   Future postDetail;
//   var jsonContent;
//   // GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
//   //
//
//   // void updateContents(value)async{
//   //   print("Not DECODED" + value);
//   //
//   //   var decoded = await jsonDecode(value);
//   //   // print("DECODED" + decoded);
//   //   setState(() {
//   //     _controller = QuillController(
//   //         document: Document.fromJson(decoded),
//   //         selection: TextSelection.collapsed(offset: 0));
//   //   });
//   //  ;
//   // }
//
//   // var scaffoldkey = new GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     postDetail = fetchDetail(widget.slug);
//     checkInitialStatus();
//     // quill = new  QuillEditor(
//     //   controller: contentController,
//     //   scrollController: new ScrollController(),
//     //   scrollable: true,
//     //   focusNode: _focusNode,
//     //   autoFocus: false,
//     //   readOnly: true,
//     //   placeholder: 'Add content',
//     //   expands: false,
//     //   padding: EdgeInsets.zero,
//     //   showCursor: false,
//     //
//     // );
//     print(widget.id);
//
//   }
//
//   @override
//   void dispose(){
//     super.dispose();
//     contentController.dispose();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // key: _scaffoldKey,
//         body: SafeArea(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             child: FutureBuilder(
//                 future: fetchDetail(widget.slug),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//
//                       // updateContents(snapshot.data['post']['content']);
//                        contentController = QuillController(
//
//                           document: Document.fromJson(jsonDecode(snapshot.data['post']['content'])),
//                           selection: TextSelection.collapsed(offset: 0),
//
//                       );
//
//                       // JsonContent =  snapshot.data['post']['content'].toString();
//                       // JsonCodec codec = new JsonCodec();
//                       // try{
//                       //   var decoded = codec.decode( jsonDecode(snapshot.data['post']['content']));
//                       //   print("Decoded 1: $decoded");
//                       //   _controller = QuillController(
//                       //       document: Document.fromJson(decoded),
//                       // selection: TextSelection.collapsed(offset: 0));
//                       // } catch(e) {
//                       //   print("Error: $e");
//                       // }
//
//
//
//                   //   return ListView(
//                   //     shrinkWrap: true,
//                   //     children: [
//                   //       // INITIAL TITLE AND INFO
//                   //       // Container(
//                   //       //   padding: EdgeInsets.all(10),
//                   //       //   child: Column(
//                   //       //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //       //     children: [
//                   //       //       // Text("CATEGORY",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2,color: Colors.pink),),
//                   //       //       Text(
//                   //       //         snapshot.data['post']['title'].toString(),
//                   //       //         style: GoogleFonts.playfairDisplay(
//                   //       //
//                   //       //           textStyle: TextStyle(
//                   //       //             height: 1.4,
//                   //       //             letterSpacing: 1.2,
//                   //       //             fontSize: 26,
//                   //       //             wordSpacing: 3,
//                   //       //             fontWeight: FontWeight.bold),
//                   //       //         )
//                   //       //       ),
//                   //       //       SizedBox(
//                   //       //         height: 10,
//                   //       //       ),
//                   //       //       //User date and action
//                   //       //
//                   //       //       SizedBox(
//                   //       //         width: 10,
//                   //       //       ),
//                   //       //
//                   //       //     ],
//                   //       //   ),
//                   //       // ),
//                   //
//                   //       // CONTENT
//                   //       Container(
//                   //           child: Image.network(
//                   //         snapshot.data['post']['coverimage'],
//                   //         fit: BoxFit.cover,
//                   //         width: MediaQuery.of(context).size.width,
//                   //         height: 260,
//                   //       )),
//                   // _buildContent(context, contentController)
//                   //       // QUILL
//                   //      // quill,
//                   //      //     QuillEditor(
//                   //      //    controller: contentController,
//                   //      //    scrollController: new ScrollController(),
//                   //      //    scrollable: true,
//                   //      //    focusNode: _focusNode,
//                   //      //    autoFocus: true,
//                   //      //    readOnly: true,
//                   //      //    placeholder: 'Add content',
//                   //      //    expands: true,
//                   //      //    padding: EdgeInsets.symmetric(horizontal: 10),
//                   //      //    showCursor: false,
//                   //      //
//                   //      //  )
//                   //
//                   //       // SingleChildScrollView(
//                   //       //
//                   //       //   child: Container(
//                   //       //     height: MediaQuery.of(context).size.height,
//                   //       //     margin: EdgeInsets.symmetric(horizontal:10),
//                   //       //     child: QuillEditor.basic(
//                   //       //
//                   //       //       controller: contentController,
//                   //       //       readOnly: true, // true for view only mode
//                   //       //
//                   //       //     ),
//                   //       //   ),
//                   //       // ),
//                   //       // QUILL EOL
//                   //       // Container(
//                   //       //     margin: EdgeInsets.all(10),
//                   //       //     child: Text(
//                   //       //       snapshot.data['post']['content'].toString(),
//                   //       //       style: TextStyle(fontSize: 16, wordSpacing: 2),
//                   //       //     )),
//                   //       // After Content
//                   //
//                   //     ],
//                   //   );
//                     return _buildContent(context, contentController);
//                   } else if (snapshot.hasError) {
//                     return Text("Error in connection");
//                   } else
//                     return Center(
//                         heightFactor: 6,
//                         child: CircularProgressIndicator());
//                 }),
//           ),
//         ),
//
//     );
//
//
//   }
//
//   Widget _buildContent(BuildContext context, QuillController controller) {
//     var quillEditor = QuillEditor(
//       enableInteractiveSelection: false,
//       // key: _scaffoldKey,
//       paintCursorAboveText: false,
//       controller: controller,
//       scrollController: ScrollController(),
//       scrollable: true,
//       focusNode: _focusNode,
//       autoFocus: true,
//       readOnly: true,
//       expands: false,
//       padding: EdgeInsets.zero,
//     );
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: quillEditor,
//       ),
//     );
//   }
//
// }
