import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/Helpers/DatabaseHelper.dart';
import 'package:mizomade/models/CategoryDBModel.dart';
import 'package:mizomade/screens/pages/CategoryPage.dart';
import 'package:mizomade/screens/pages/MainPage.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/screens/pages/Tabs/Search/SearchResultPage.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:mizomade/widgets/SearchSuggestionCard.dart';
import 'package:mizomade/widgets/Sidebar.dart';

import '../../TagPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future postlist;
  DatabaseHelper dbHelper;
  Future<List<CategoryDBModel>> dbs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _search = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> suggestions_chips = [
    'Eisiam',
    'Gospel',
    'Infiamna',
    'Thiamna'
  ];

  final List popular_posts = [
    {
      'title': 'This is a title1 ',
      'date': '12 Dec 2021',
      'image':
          'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80'
    },
  ];
@override
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    dbs = dbHelper.retrieveCategories();
    // dbHelper.deleteDatabase();

    // this.dbHelper.initDB().whenComplete(() async {
    //   setState(() {
    //     CategoryDBModel category =
    //         new CategoryDBModel(name: "Eisiam", color: "RED");
    //     dbHelper.insertCategory(category);
    //     print("DBS" + dbs.asStream().toString());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          //       enabled: false,
          //
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
          //       // onEditingComplete: (){
          //       //     setState(() {
          //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResultPage()));
          //       //     });
          //       // },
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => SearchResultPage()));
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchResultPage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.black38),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.96,
            height: 30,
          //   child: FutureBuilder<List<CategoryDBModel>>(
          //       future: dbs,
          //       builder: (BuildContext context, AsyncSnapshot<List<CategoryDBModel>> snapshot) {
          //         if (snapshot.hasData) {
          //           return ListView.builder(
          //             physics: BouncingScrollPhysics(),
          //
          //             scrollDirection: Axis.horizontal,
          //             itemExtent: 90,
          //             itemCount: snapshot.data.length,
          //             itemBuilder: (context, index) {
          //               return TagsChip(snapshot.data[index].name.toString());
          //             },
          //           );
          //         } else if (snapshot.hasError) {
          //           return Text("..");
          //         }
          //         else {
          //           return TagsChip("       ");
          //         }
          //       }),
          // ),
            child: FutureBuilder(
                future: categoryList(),
                builder: (BuildContext context,  snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),

                      scrollDirection: Axis.horizontal,
                      itemExtent: 90,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // return TagsChip(snapshot.data[index].name.toString());
                        return CategoryChip(snapshot.data[index]['name'].toString());

                      // return Text("asdfas");
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("..");
                  }
                  else {
                    return CategoryChip("       ");
                  }
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: InputChip(label: Text("Popular Posts"),
            avatar: Icon(Icons.stream),

            disabledColor:  Theme.of(context).disabledColor),
          ),
          FeaturedPosts(),

          // Suggestions(),
        ],
      ),
    );
  }

  Widget CategoryChip(String text) {
    return InputChip(
      // avatar: Icon(Icons.remove),
      label: Text(
        text,
        // style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      category: text,
                    )));
      },
    );
  }

  // Widget Suggestions() {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: popular_posts.length,
  //       itemBuilder: (context, index) {
  //         return SugeestionCards(
  //           context,
  //           popular_posts[index]['title'].toString(),
  //           popular_posts[index]['date'].toString(),
  //           popular_posts[index]['author'].toString(),
  //           popular_posts[index]['image'].toString(),
  //         );
  //       });
  // }


  Widget FeaturedPosts(){
  return FutureBuilder(
      future: featuredPosts(),
      builder: (BuildContext context, snapshot) {
    if(snapshot.hasData){
      return ListView.builder(
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context,index){
        // return Text(snapshot.data[index]['title']);
            return SearchSuggestionCards(
              context,
              snapshot.data[index]['id'].toString(),

              snapshot.data[index]['title'].toString(),
              snapshot.data[index]['date'].toString(),
              snapshot.data[index]['author'].toString(),
              snapshot.data[index]['coverimage'].toString(),
              snapshot.data[index]['slug'].toString(),

            );
      }



    );

    }

    else{
      return CircularProgressIndicator();
  }}
    );



  }


}

