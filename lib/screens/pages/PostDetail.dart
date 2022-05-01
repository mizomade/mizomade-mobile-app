import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mizomade/screens/pages/RelatedPost/Related.dart';
import 'package:mizomade/screens/pages/UserPage.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/utils/Texts.dart';

import 'Comment/CommentList.dart';
import 'TagPage.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetail extends StatefulWidget {
  // const PostDetail({Key? key}) : super(key: key);
  String slug;
  String id;

  PostDetail({this.slug, this.id});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  var tags;
  bool likestatus;
  bool bookmarkstatus;
  final FocusNode _focusNode = FocusNode();

  // QuillController _controller = QuillController.basic();

  Future fetchdetail(String slug) async {
    print("INITTTT");
    var response = await http.get(Uri.parse(API_URL + 'posts/' + slug));
    print("RESPONES" + json.decode(response.body).toString());

    if (response.statusCode == 200) {

      print("True");
      tags = jsonDecode(response.body)['post']['tags'];
      return jsonDecode(response.body);
    } else {
      print("Error");
    }
  }

  void CheckInitialStatus() async {
    var LikeResult = await checkLikeStatus(widget.id.toString());
    if (LikeResult == 1) {
      setState(() {
        likestatus = true;
      });
    } else if (LikeResult == 0) {
      setState(() {
        likestatus = false;
      });
    }
    var Bookmarkresult = await checkBookmarkStatus(widget.id.toString());
    if (Bookmarkresult == 1) {
      setState(() {
        bookmarkstatus = true;
      });
    } else if (Bookmarkresult == 0) {
      setState(() {
        bookmarkstatus = false;
      });
    }
  }

  Future postdetail;
  var JsonContent;

  // void updateContents(value)async{
  //   print("Not DECODED" + value);
  //
  //   var decoded = await jsonDecode(value);
  //   // print("DECODED" + decoded);
  //   setState(() {
  //     _controller = QuillController(
  //         document: Document.fromJson(decoded),
  //         selection: TextSelection.collapsed(offset: 0));
  //   });
  //  ;
  // }

  final AdSize adSize = AdSize(width: 300,height: 50);
  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    postdetail = fetchdetail(widget.slug);
    CheckInitialStatus();
    print(widget.id);
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBar(
      //     backgroundColor: Colors.white,
      //     elevation: 0.5,
      //     title: Text(
      //       "MizoMade",
      //       style: TextStyle(color: Colors.black,letterSpacing: 3),
      //     ),
      //     leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios_outlined,
      //         color: Colors.black,
      //       ),
      //
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 1,
            floating: true,
            snap: true,

            title: Text(
              "Mizomade",
              style: TextStyle( letterSpacing: 2),
            ),
            centerTitle: false,
            // backgroundColor: Colors.white,
            // foregroundColor: Colors.black,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_outlined,color: Colors.black87,
            //   ),
            //   onPressed: (){
            //     Navigator.pop(context);
            //   },
            // ),
          )
        ],
        body: SingleChildScrollView(
          child: SizedBox(
            // width: double.infinity,
            // height: MediaQuery.of(context).size.height*4,
            // alignment: Alignment.topCenter,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: NetworkImage(
            //           "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4",
            //         ),
            //         fit: BoxFit.cover)),
            child: FutureBuilder(
                future: postdetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                      // updateContents(snapshot.data['post']['content']);
                      QuillController contentController = QuillController(

                          document: Document.fromJson(jsonDecode(snapshot.data['post']['content'])),
                          selection: TextSelection.collapsed(offset: 0),

                      );

                      // JsonContent =  snapshot.data['post']['content'].toString();
                      // JsonCodec codec = new JsonCodec();
                      // try{
                      //   var decoded = codec.decode( jsonDecode(snapshot.data['post']['content']));
                      //   print("Decoded 1: $decoded");
                      //   _controller = QuillController(
                      //       document: Document.fromJson(decoded),
                      // selection: TextSelection.collapsed(offset: 0));
                      // } catch(e) {
                      //   print("Error: $e");
                      // }



                    return Container(
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // INITIAL TITLE AND INFO
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("CATEGORY",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2,color: Colors.pink),),

                                Text(
                                  snapshot.data['post']['title'].toString(),
                                  style: GoogleFonts.playfairDisplay(

                                    textStyle: TextStyle(
                                      height: 1.2,
                                      letterSpacing: 1,
                                      fontSize: 22,
                                      wordSpacing:1 ,
                                      fontWeight: FontWeight.w800),
                                  )
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //User date and action
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 26,
                                              child: ClipOval(
                                                  child: Image.network(
                                                   S3_Host + snapshot.data['post']
                                                        ['authorphoto'],
                                                width: 45,
                                                height: 45,
                                                fit: BoxFit.cover,
                                              )),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data['post']
                                                    ['author'],
                                                    style: GoogleFonts.poppins(fontSize: 14,letterSpacing: 2,fontWeight: FontWeight.w600)),
                                                Text(dateFormat(snapshot
                                                    .data['post']['date']),style: GoogleFonts.poppins(fontSize: 12,letterSpacing: 2,)),
                                              ],
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserPage(username: snapshot.data['post']['author'],)));
                                        },
                                      ),
                                      Wrap(
                                        children: [
                                          IconButton(
                                              splashColor: Colors.pink[50],
                                              icon: likestatus == true
                                                  ? Icon(
                                                      Icons.favorite_outlined,
                                                      color: Colors.pink,
                                                    )
                                                  : Icon(Icons
                                                      .favorite_border_outlined),
                                              onPressed: () async {
                                                var result = await like(snapshot
                                                    .data['post']['id']
                                                    .toString());
                                                print("RESULT" +
                                                    result.toString());

                                                if (result.toString() == "1") {
                                                  setState(() {
                                                    likestatus = true;
                                                  });
                                                } else if (result.toString() ==
                                                    "0") {
                                                  setState(() {
                                                    likestatus = false;
                                                  });
                                                }
                                              }),
                                          IconButton(
                                              icon: bookmarkstatus == true
                                                  ? Icon(
                                                      Icons.bookmark_outlined,

                                                    )
                                                  : Icon(Icons
                                                      .bookmark_border_outlined),
                                              onPressed: () async {
                                                var result = await bookmark(snapshot
                                                    .data['post']['id']
                                                    .toString());
                                                print("RESULT" +
                                                    result.toString());

                                                if (result.toString() == "1") {
                                                  setState(() {
                                                    bookmarkstatus = true;
                                                  });
                                                } else if (result.toString() ==
                                                    "0") {
                                                  setState(() {
                                                    bookmarkstatus = false;
                                                  });
                                                }
                                              })
                                        ],
                                      )
                                    ]),
                              ],
                            ),
                          ),

                          // CONTENT
                          Container(
                              child: Image.network(
                            snapshot.data['post']['coverimage'],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 260,
                          )),
                          // Text("This is content"),

                          // QUILL

                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: QuillEditor(
                                  controller: contentController,
                                  scrollController: ScrollController(),
                                  scrollable: true,
                                  focusNode: _focusNode,
                                  autoFocus: false,
                                  readOnly: true,
                                  placeholder: 'Add content',
                                  expands: false,
                                  padding: EdgeInsets.zero,
                                  showCursor: false,

                                  ),
                            ),
                          ),

                          // SingleChildScrollView(
                          //
                          //   child: Container(
                          //     margin: EdgeInsets.symmetric(horizontal:10),
                          //     child: QuillEditor.basic(
                          //
                          //
                          //       controller: _controller,
                          //       readOnly: true, // true for view only mode
                          //
                          //     ),
                          //   ),
                          // ),
                          // QUILL EOL
                          // Container(
                          //     margin: EdgeInsets.all(10),
                          //     child: Text(
                          //       snapshot.data['post']['content'].toString(),
                          //       style: TextStyle(fontSize: 16, wordSpacing: 2),
                          //     )),
                          // After Content
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Category : "),
                                    Text(
                                      snapshot.data['post']['category'].toString().toUpperCase(),
                                      style: GoogleFonts.oswald(

                                        textStyle: TextStyle(
                                            height: 1.4,
                                            letterSpacing: 2,
                                            fontSize: 12,
                                            wordSpacing: 3,
                                            foreground: Paint() ..shader = TextUtils().linearGradient,
                                            fontWeight: FontWeight.bold),
                                      )
                                  ),]
                                ),
                                // TAGS
                                Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runSpacing: -6,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      "Tags:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(width: 10,),
                                    // ListView.builder(
                                    //
                                    //   itemCount:snapshot.data['post']['tags'].toString().length ,
                                    //   itemBuilder: (BuildContext context,index){
                                    //     return Text(snapshot.data['post']['tags'][index].toString());
                                    //
                                    //   },
                                    // ),
                                    for (var item in snapshot.data['post']
                                        ['tags'])
                                      InputChip(
                                        label: Text(
                                          "#" + item,
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TagPage(tag: item,)));
                                        },
                                      ),
                                  ],
                                ),
                                // COMMENTS

                                Divider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.question_answer_outlined,
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) => CommentList(
                                              id: snapshot.data['post']['id']
                                                  .toString(),
                                            ));
                                  },
                                  title: Row(children: [
                                    Text(
                                      "Comments ",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Icon(
                                      Icons.hdr_strong_outlined,
                                      color: Colors.red.shade300,
                                    )
                                  ]),
                                ),
                                Divider(),

                                // RELATED
                                Text(
                                  "Related",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                snapshot.data['related'].toString().length >= 3 ? SizedBox(
                                    height: 400,
                                    child: Related(
                                      relatedList: snapshot.data['related'],
                                    )):SizedBox(
                                  child: Text("No related post exists"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error in connection");
                  } else
                    return Center(
                        heightFactor: 6,
                        child: CircularProgressIndicator());
                }),
          ),
        ),
      ),
    );
  }

  Widget buildComments() => Container(
        // height: MediaQuery.of(context).size.height*0.1,
        height: 100,
        child: Text("HELLo"),
      );
}
