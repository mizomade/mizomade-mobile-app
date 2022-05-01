import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/screens/pages/Comment/CreateDialogue.dart';
import 'package:mizomade/screens/pages/Comment/DeleteDialogue.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/screens/pages/Comment/EditDialogue.dart';
import 'package:mizomade/utils/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/Network.dart';

class CommentList extends StatefulWidget {
  // const CommentList({Key key}) : super(key: key);
  String id;

  CommentList({this.id});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Future commentlist;
  String username;
  String profilephoto;



 fetchusername() async{
   String value = await storage.read(key: 'username');
   print(value);
   final prefs = await SharedPreferences.getInstance();
   setState(() {
     username = value;
     profilephoto = prefs.getString('profilephoto');
     print(profilephoto);
   });

}


  @override
  void initState() {
    super.initState();
    fetchusername();

    setState(() {
      commentlist = fetchComments(widget.id);

    });
    print("username" + username.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Comments",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close))
                ])),
            Divider(),
            // FloatingActionButton.extended(
            //   isExtended: true,
            //   onPressed: (){
            //     showModalBottomSheet(context: context,
            //         isScrollControlled: true,
            //         builder: (context) => CreateComment());
            //   },
            //   label: Text("Add comment"),
            //
            // ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                showDialog<void>(
                    barrierDismissible: false, // user must tap button!

                    context: context,
                    builder: (context) => CreateDialogue(id: widget.id,username:username));
              },
              leading: CircleAvatar(

                child: ClipOval(
                  child: Image.network(profilephoto,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,

                ),
                
                child: Padding(
                    padding: EdgeInsets.only(top: 16,left: 10),
                    child: Text("Add comment ... ")),
              ),
            ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       showDialog<void>(
            //           barrierDismissible: false, // user must tap button!
            //
            //           context: context,
            //           builder: (context) => CreateDialogue());
            //     },
            //     child: Text("Add Comment")),
            Divider(),

            // ListTile(
            //   title: Text("Hmangaiha"),
            //   leading: Icon(Icons.account_circle_outlined),
            // ),
            SizedBox(
              // height: 400,
              height: MediaQuery.of(context).size.height * 0.65,

              child: FutureBuilder(
                future: commentlist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index]['user'] +" ,  "+
                                    dateFormat(snapshot.data[index]['date']),style: GoogleFonts.abel(),),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                   snapshot.data[index]['comment']),
                                snapshot.data[index]['user'] == username.toString() ?  Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // TextButton(
                                    //     onPressed: () {}, child: Text("Like")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog<void>(
                                              context: context,
                                              builder: (context) =>
                                                  EditDialogue(id: widget.id, comment_id:snapshot.data[index]['id'].toString(),content: snapshot.data[index]['comment'].toString(),username: username,));
                                        },  child: Text("Edit ")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          showDialog<void>(
                                              context: context,
                                              builder: (context) =>
                                                  DeleteDialogue(comment_id:snapshot.data[index]['id'].toString(),id:widget.id));
                                        },
                                        child: Text("Delete")),
                                  ],
                                ):SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          leading: CircleAvatar(

                            child: ClipOval(
                              child: Image.network(S3_Host + snapshot.data[index]['profilephoto'],
                              height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text("Error");
                  }
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
