import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/Helpers/DatabaseHelper.dart';
import 'package:mizomade/models/CategoryDBModel.dart';
import 'package:mizomade/screens/pages/CategoryPage.dart';

import 'package:mizomade/screens/pages/Tabs/Search/SearchResultPage.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/widgets/SearchSuggestionCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseHelper dbHelper;
  Future<List<CategoryDBModel>> dbs;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    dbs = dbHelper.retrieveCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
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
            child: FutureBuilder(
                future: categoryList(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemExtent: 90,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // return TagsChip(snapshot.data[index].name.toString());
                        return CategoryChip(
                            snapshot.data[index]['name'].toString());

                        // return Text("asdfas");
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("..");
                  } else {
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
            child: InputChip(
                label: Text("Popular Posts"),
                avatar: Icon(Icons.stream),
                disabledColor: Theme.of(context).disabledColor),
          ),
          FeaturedPosts(),

          // Suggestions(),
        ],
      ),
    );
  }

  Widget CategoryChip(String text) {
    return InputChip(
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

  Widget FeaturedPosts() {
    return FutureBuilder(
        future: featuredPosts(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
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
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
