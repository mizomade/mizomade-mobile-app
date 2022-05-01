
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';


class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future postlist;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _search = TextEditingController();

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
            SizedBox(
              height: 10,
            ),
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

Widget SugeestionCards(BuildContext context, String id, String title,
    String date, String author, String coverphoto, String slug) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetail(
                    id: id,
                    slug: slug,
                  )));
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
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@" + author,
                  style: GoogleFonts.abel(),
                ),

                Text(
                  dateFormat(date),
                  style: GoogleFonts.abel(),
                ),
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
    label: Text(
      'Eisiam',
      style: TextStyle(color: Colors.black54),
    ),
    onSelected: (bool value) {},
  );
}
