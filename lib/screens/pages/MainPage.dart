import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mizomade/main.dart';
import 'package:mizomade/screens/Action/CreatePost/CreatePost.dart';
import 'package:mizomade/screens/accounts/Login.dart';
import 'package:mizomade/screens/accounts/ProfilePage.dart';
import 'package:mizomade/screens/accounts/Settings/SettingsPage.dart';
import 'package:mizomade/screens/pages/UserPage.dart';
import 'package:provider/provider.dart';

import '../../utils/States.dart';
import 'Tabs/Home.dart';
import 'Tabs/Saved.dart';
import 'Tabs/Search/SearchPage.dart';
import 'Tabs/user/MyProfilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  GlobalKey Globalscaffoldkey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  // ScrollController scrollViewController = ScrollController();
  // bool _showAppBar = true;
  // bool isScrollingDown = true;
  // bool _show = true;

  // Future<dynamic> navigateTo(Widget routeName) {
  //   return MyApp.navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=> routeName));
  // }
  // void showBottomBar() {
  //   setState(() {
  //     print("SHOWW");
  //     _show = true;
  //   });
  // }
  //
  // void hideBottomBar() {
  //   setState(() {
  //     _show = false;
  //   });
  // }
  //
  // void myScroll() async {
  //   print("SCROLL INIT");
  //   scrollViewController.addListener(() {
  //     if (scrollViewController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       if (!isScrollingDown) {
  //         isScrollingDown = true;
  //         _showAppBar = false;
  //         print("HELLO");
  //         hideBottomBar();
  //
  //         // setState(() {});
  //       }
  //     }
  //
  //     if (scrollViewController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       if (isScrollingDown) {
  //         isScrollingDown = false;
  //         _showAppBar = true;
  //         showBottomBar();
  //         print("SHOW BUTTON");
  //
  //         // setState(() {});
  //       }
  //     }
  //   });
  // }



  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // final List<Widget> pages = const <Widget>[
  //   Home(key:PageStorageKey<String>('home')),
  //   // Text(      'Index 1: Business',      style: optionStyle,    ),
  //   SearchPage(key: PageStorageKey<String>('search'),),
  //   SavedPosts(key:PageStorageKey<String>('saved')),
  //
  //   MyProfilePage(key:PageStorageKey<String>('myprofile'))
  //
  // ];


  // final PageStorageBucket _bucket = PageStorageBucket();


  // static const TextStyle optionStyle =      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    Home(),
    // Text(      'Index 1: Business',      style: optionStyle,    ),
    SearchPage(),
    SavedPosts(),

    MyProfilePage()
  ];

  // static const List page= ["Mizomade", "Search", "Saved", "Profile"];
  // static List<Widget> actions =<Widget> [
  //   Icon(
  // Icons.settings,
  // color: Colors.black54,
  // ),
  //   Icon(
  //     Icons.settings,
  //     color: Colors.black54,
  //   ),
  //   Icon(
  //     Icons.settings,
  //     color: Colors.black54,
  //   ),
  //   Icon(
  //     Icons.settings,
  //     color: Colors.black54,
  //   ),
  // ];
  // static List<Widget> actionOptions = <Widget>[
  //   Padding(
  //     padding: const EdgeInsets.only(right: 20),
  //     child: IconButton(
  //       icon: Icon(
  //         Icons.notifications_outlined,
  //         color: Colors.black54,
  //       ),
  //       onPressed: () {
  //         // Navigator.of(context).push(_settingsRoute());
  //       },
  //     ),
  //   ),
  //   Padding(
  //     padding: const EdgeInsets.only(right: 20),
  //   ),
  //   Padding(
  //     padding: const EdgeInsets.only(right: 20),
  //     child: IconButton(
  //       icon: Icon(
  //         Icons.bookmark,
  //         color: Colors.black54,
  //       ),
  //       onPressed: () {},
  //     ),
  //   ),
  //   Padding(
  //     padding: const EdgeInsets.only(right: 20),
  //     child: IconButton(
  //       icon: Icon(
  //         Icons.settings_outlined,
  //         color: Colors.black54,
  //       ),
  //       onPressed: () {
  //         // navigateTo();
  //       },
  //     ),
  //   ),
  // ];
  //
  //

  @override
  void initState() {
    print("INITSTATE");
    super.initState();
    // scrollViewController = new ScrollController();
    //
    // setState(() {
    //   myScroll();
    //
    // });

  }

  @override
  void dispose() {
    // scrollViewController.dispose();
    // scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return  Consumer<Profile>(
        builder: (context,provider,child) {
          return
            provider.isAuthenticated == true ? Scaffold(
      // key: scaffoldkey,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBar(
      //     elevation: 0,
      //     centerTitle: false,
      //     leadingWidth: 0,
      //     title: Text(
      //       page[selectedIndex],
      //       style: TextStyle(color: Colors.black87,letterSpacing: 2),
      //     ),
      //
      //     backgroundColor: Colors.white,
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: Icon(
      //           Icons.notifications_outlined,
      //           color: Colors.black54,
      //         ),
      //       )
      //     ],
      //     // leading: IconButton(
      //     //     onPressed: (){setState(() {
      //     //       scaffoldkey.currentState.openDrawer();
      //     //     });},
      //     //     icon: Icon(
      //     //       Icons.menu,
      //     //       color: Colors.black54,
      //     //
      //     //     )),
      //   ),
      // ),
      // drawer: Drawer(child: Sidebar(),),

      // AnimatedContainer(
      //   height: _showAppBar ? 50.0 : 0.0,
      //   duration: Duration(milliseconds: 200),
      //   child: AppBar(
      //     elevation: 0,
      //     centerTitle: false,
      //     leadingWidth: 0,
      //     title: Text(
      //       pages[selectedIndex],
      //       style: TextStyle(color: Colors.black87, letterSpacing: 2),
      //     ),
      //     backgroundColor: Colors.white,
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: IconButton(
      //           icon:
      //             actions[selectedIndex],
      //
      //           onPressed: () {
      //             // print(actions[selectedIndex][0].toString());
      //             // navigateTo();
      //             // navigateTo(actions[selectedIndex][1]);
      //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> actions[selectedIndex][1]));
      //           },
      //
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),

      // body: ListView(
      //
      //       scrollDirection: Axis.vertical,
      //       shrinkWrap: true,
      //       // physics: AlwaysScrollableScrollPhysics(),
      //       children: [
          // AnimatedContainer(
          //   height: _showAppBar ? 50.0 : 0.0,
          //   duration: Duration(milliseconds: 200),
          //   child: AppBar(
          //     elevation: 0,
          //     centerTitle: false,
          //     leadingWidth: 0,
          //     title: Text(
          //       pages[selectedIndex],
          //       style: TextStyle(color: Colors.black87, letterSpacing: 2),
          //     ),
          //     backgroundColor: Colors.white,
          //     actions: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 20),
          //         child: IconButton(
          //           icon:
          //             actions[selectedIndex],
          //
          //           onPressed: () {
          //             // print(actions[selectedIndex][0].toString());
          //             // navigateTo();
          //             // navigateTo(actions[selectedIndex][1]);
          //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> actions[selectedIndex][1]));
          //           },
          //
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // ),
        //   IndexedStack(
        //
        //       index: selectedIndex,
        //       children: widgetOptions),
        // ]),
      body: IndexedStack(
            key: Globalscaffoldkey,
             index: selectedIndex,
             children: widgetOptions),

      // body: PageStorage(
      //   bucket: _bucket,
      //   child: pages[selectedIndex],
      // ),
      // floatingActionButton: Visibility(
      //   visible: _show,
      //   child: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => CreatePost()));
      //     },
      //     // tooltip: 'Increment',
      //     // child: Icon(Icons.add),
      //     icon: Icon(Icons.mode_edit_outline_outlined),
      //     label: Text("Create"),
      //     elevation: 7,
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //
      //     backgroundColor: Colors.purple,
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: SizedBox(
        height: 52,
        child: BottomNavigationBar(
          iconSize: 22,
          // backgroundColor: Colors.white,
          // fixedColor: Colors.green,
          selectedItemColor: Theme.of(context).iconTheme.color,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,

          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                label: "Home",
                icon: Icon(
                  Icons.home_outlined,
                )),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: "Bookmarked", icon: Icon(Icons.bookmark_border)),
            BottomNavigationBarItem(
                label: "Profile", icon: Icon(Icons.account_circle_sharp)),
          ],
        ),
      ),
    ):LoginPage();
  }
    );

}
  Route _settingsRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SettingsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(10, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
