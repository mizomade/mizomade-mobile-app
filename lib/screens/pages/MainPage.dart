import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizomade/screens/accounts/Login.dart';

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

class _MainPageState extends State<MainPage> {
  GlobalKey globalScaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static List<Widget> widgetOptions = <Widget>[
    Home(),
    SearchPage(),
    SavedPosts(),
    MyProfilePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<Profile>(builder: (context, provider, child) {
      return provider.isAuthenticated == true
          ? Scaffold(
              body: IndexedStack(
                  key: globalScaffoldKey,
                  index: selectedIndex,
                  children: widgetOptions),
              bottomNavigationBar: SizedBox(
                height: 52,
                child: BottomNavigationBar(
                  iconSize: 22,
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
                    BottomNavigationBarItem(
                        label: "Search", icon: Icon(Icons.search)),
                    BottomNavigationBarItem(
                        label: "Bookmarked", icon: Icon(Icons.bookmark_border)),
                    BottomNavigationBarItem(
                        label: "Profile",
                        icon: Icon(Icons.account_circle_sharp)),
                  ],
                ),
              ),
            )
          : LoginPage();
    });
  }
}
