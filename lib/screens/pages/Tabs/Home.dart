import 'package:flutter/material.dart';
import 'package:mizomade/Helpers/DatabaseHelper.dart';
import 'package:mizomade/models/CategoryDBModel.dart';
import 'package:mizomade/models/PostListModel.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';

import 'package:mizomade/utils/PostListAPI.dart';
import 'package:mizomade/widgets/PostCard.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../Action/CreatePost/CreatePost.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  DatabaseHelper dbHelper;

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

    // this.dbHelper = DatabaseHelper();
    // dbHelper.insertCategoryList();

    // this.dbHelper.initDB().whenComplete(() async {
    //   setState(() {
    //     Future<List<CategoryDBModel>> dbs = dbHelper.retrieveCategories();
    //     print("DBS" + dbs.asStream().toString());
    //   });
    // });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);

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
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                snap: true,
                title: const Text(
                  'Mizomade',
                  style: TextStyle(letterSpacing: 2),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
                separatorBuilder: (BuildContext context, int index) => const Divider(),


                builderDelegate: PagedChildBuilderDelegate<Results>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute(
                          item.slug.toString(), item.id.toString()));
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

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
        heroTag: 'create',
        icon: Icon(Icons.mode_edit_outline_outlined),
        label: Text(
          "Create",
        ),
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        foregroundColor:
            Theme.of(context).floatingActionButtonTheme.foregroundColor,
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
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
