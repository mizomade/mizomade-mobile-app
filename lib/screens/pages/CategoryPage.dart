import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:mizomade/Helpers/DatabaseHelper.dart';
import 'package:mizomade/models/CategoryDBModel.dart';
import 'package:mizomade/models/PostListModel.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/CategoryListAPI.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:mizomade/utils/PostListAPI.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';





class CategoryPage extends StatefulWidget {
  // const CategoryPage({Key key}) : super(key: key);
  String category;
  CategoryPage({this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin {
  Future postlist;

  ScrollController scrollViewController = ScrollController();


  static const _pageSize = 12;

  final PagingController<int, Results> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    // postlist = fetchInitial();
    super.initState();


  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await CategoryRemoteApi.getCharacterList(pageKey, _pageSize,searchTerm: widget.category.toString());

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    List buildTextViews(int count) {
      List<Widget> strings = List();
      for (int i = 0; i < count; i++) {
        strings.add(new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Text("Item number " + i.toString(),
                style: new TextStyle(fontSize: 20.0))));
      }
      return strings;
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                snap: true,
                title:  Row(
                  children: [ const Text(
                    'Category  ',
                    style: TextStyle(color: Colors.black87, letterSpacing: 2),
                  ),
                    InputChip(label: Text(
                        widget.category.toString()
                    ),
                      disabledColor: Colors.grey.shade200,
                    )
                  ]
                ),
                automaticallyImplyLeading: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                toolbarHeight: kToolbarHeight,
                elevation: 0.4,
              )
            ];
          },
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PagedListView<int, Results>.separated(
                pagingController: _pagingController,

                builderDelegate: PagedChildBuilderDelegate<Results>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          _createRoute(item.slug.toString(), item.id.toString()));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PostDetailTest(
                      //               id: item.id.toString(),
                      //               slug: item.slug.toString(),
                      //             )));
                    },
                    child: (PostCard(
                      title: item.title.toString(),
                      author: item.author.toString(),
                      date: item.date,
                      authorimage: item.authorphoto.toString(),
                      coverimage: item.coverimage.toString(),
                    )
                        // Text(item.title)
                    ),
                  ),
                ),
                // separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          )),
      // Thi)

    );
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }
}

Route _createRoute(String slug, String id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PostDetail(
      slug: slug,
      id: id,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}