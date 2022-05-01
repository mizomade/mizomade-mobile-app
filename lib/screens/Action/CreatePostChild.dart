//
//
// import 'package:flutter/material.dart';
// import 'package:zefyrka/zefyrka.dart';
//
//
//
// class CreatePost extends StatefulWidget {
//   const CreatePost({Key key}) : super(key: key);
//
//   @override
//   _CreatePostState createState() => _CreatePostState();
// }
//
// class _CreatePostState extends State<CreatePost> {
//   ZefyrController _controller = ZefyrController();
//
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Here we must load the document and pass it to Zefyr controller.
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Note that the editor requires special `ZefyrScaffold` widget to be
//     // one of its parents.
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               ZefyrToolbar.basic(controller: _controller),
//               Expanded(
//                 child: ZefyrEditor(
//                   controller: _controller,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
//
//
// }
//
//
