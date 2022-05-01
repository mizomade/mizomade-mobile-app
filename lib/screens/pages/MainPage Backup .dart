import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Tabs/Home.dart';
import 'Tabs/Saved.dart';
import 'Tabs/Search/SearchPage.dart';
import 'Tabs/user/MyProfilePage.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{
  final scaffoldkey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  
  
  ScrollController _scrollViewController = ScrollController();
  bool _showAppBar = true;
  bool isScrollingDown = true;
  bool _show = true;


  void showBottomBar() {
    setState(() {
      print("TETSTT");
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }
  void myScroll() async {
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppBar = false;
          hideBottomBar();

          // setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppBar = true;
          showBottomBar();

          // setState(() {});
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    myScroll();

  }

  @override
  void dispose(){
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() { });
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    Home(),
    // Text(      'Index 1: Business',      style: optionStyle,    ),
    SearchPage(),
    SavedPosts(),
    // Text(
    //   'Index 3: Settings',
    //   style: optionStyle,
    // ),
    MyProfilePage()
  ];

  static const List pages =[
    // Text('MizoMade'),
    // Text(''),
    // Text('Saved'),
    "Mizomade",
    "Search",
    "Saved",
    "Profile"

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBar(
      //     elevation: 0,
      //     centerTitle: false,
      //     leadingWidth: 0,
      //     title: Text(
      //       pages[_selectedIndex],
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
      body: SafeArea(
        
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppBar ? 56.0 : 0.0,
              duration: Duration(milliseconds: 200),
            child: AppBar(

              elevation: 0,
              centerTitle: false,
              leadingWidth: 0,
              title: Text(
                pages[_selectedIndex],
                style: TextStyle(color: Colors.black87,letterSpacing: 2),
              ),

              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.black54,
                  ),
                )
              ],

            ),),
            
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
              child: _widgetOptions.elementAt(_selectedIndex),
          ),
            ),]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        tooltip: 'Increment',
        // child: Icon(Icons.add),
        icon: Icon(Icons.add),
        label: Text("Create"),

        backgroundColor: Colors.green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: SizedBox(
        height:52,
        child: BottomNavigationBar(
          iconSize: 22,
          backgroundColor: Colors.white,
          // fixedColor: Colors.green,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black26,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,


          items: [
            BottomNavigationBarItem(activeIcon: Icon(Icons.home),
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
    );
  }
}
