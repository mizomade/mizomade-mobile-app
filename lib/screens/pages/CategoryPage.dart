import 'package:flutter/material.dart';

import 'package:mizomade/models/PostListModel.dart';
import 'package:mizomade/screens/pages/PostDetail.dart';
import 'package:mizomade/utils/CategoryListAPI.dart';

import 'package:mizomade/widgets/PostCard.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryPage extends StatefulWidget {
  // const CategoryPage({Key key}) : super(key: key);
  final String category;

  CategoryPage({this.category});

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
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
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await CategoryRemoteApi.getCharacterList(
          pageKey, _pageSize,
          searchTerm: widget.category.toString());

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
                title: Row(children: [
                  const Text(
                    'Category  ',
                    style: TextStyle(color: Colors.black87, letterSpacing: 2),
                  ),
                  InputChip(
                    label: Text(widget.category.toString()),
                    disabledColor: Colors.grey.shade200,
                  )
                ]),
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
