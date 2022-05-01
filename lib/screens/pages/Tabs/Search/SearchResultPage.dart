import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/screens/pages/MainPage.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:mizomade/widgets/Sidebar.dart';

class SearchResultPage extends StatefulWidget {
  // const SavedPosts({Key key}) : super(key: key);
  // String query;
  //
  // SearchResultPage({this.query});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future postlist;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _search = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          height: 46,
          margin: EdgeInsets.only(right: 10),
          child: TextFormField(
            controller: _search,
            autofocus: true,
            decoration: InputDecoration(
                focusColor: Colors.white,
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      _search.text = "";
                    },
                    icon: Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                    ))),
            onEditingComplete: () {
              setState(() {
                postlist = search(_search.text);
              });
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   height: 40,
            //   child: Form(
            //     key: _formKey,
            //     child: TextFormField(
            //       controller: _search,
            //       autofocus: false,
            //       decoration: InputDecoration(
            //         focusColor: Colors.white,
            //         fillColor: Colors.grey.shade200,
            //         filled: true,
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           borderSide: BorderSide.none,
            //         ),
            //         prefixIcon: Icon(Icons.search),
            //         labelText: "Search ",
            //       ),
            //       onEditingComplete: () {
            //         setState(() {
            //           postlist = search(_search.text);
            //         });
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.96,
            //   height: 30,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     itemExtent: 80,
            //     children: [
            //       TagsChip(),
            //       TagsChip(),
            //       TagsChip(),
            //       TagsChip(),
            //       TagsChip(),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Divider(),
            Suggestions(context),
          ],
        ),
      ),
    );
  }

  Widget Suggestions(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: FutureBuilder(
          future: postlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data[0].length,
                  itemBuilder: (context, index) {
                    return SugeestionCards(
                        context,
                        snapshot.data[0][index]['id'].toString(),

                        snapshot.data[0][index]['title'],
                        snapshot.data[0][index]['date'],
                        snapshot.data[0][index]['author'],
                        snapshot.data[0][index]['coverimage'],
                        snapshot.data[0][index]['slug']);
                  });
            } else if (snapshot.hasError) {
              print("Error");
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

Widget SugeestionCards(BuildContext context, String id, String title, String date,
    String author, String coverphoto, String slug) {
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetail(id: id,slug: slug,)));
    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: coverphoto.toString() != 'null'
                  ? Image.network(
                      coverphoto,
                      width: 110,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(
                      width: 110,
                      height: 90,
                    )),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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




Widget TagsChip() {
  return InputChip(
    // avatar: Icon(Icons.remove),
    label: Text(
      'Eisiam',
      style: TextStyle(color: Colors.black54),
    ),
    onSelected: (bool value) {},
  );
}
