import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/CategoryPage.dart';
class Sidebar extends StatefulWidget {
  String selected ='';

  // const Drawer({Key key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(child:
        Container(
          child: Text("Categories"),
        )),
        ListTile(
          selected: widget.selected == 'Eisiam',
          onTap: ()=> setState(()=> widget.selected = 'Eisiam'),
          selectedTileColor: Theme.of(context).primaryColor,
          leading: Icon(
            Icons.restaurant_outlined,
          ),
          title: Text("Eisiam"),
        ),
        ListTile(
          selected: widget.selected == 'Zirna',
          onTap:()=>setState(()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryPage()))),
          selectedTileColor: Theme.of(context).primaryColorLight,
          leading: Icon(
            Icons.restaurant_outlined,
          ),
          title: Text("Zirna"),
        )
      ],
    );
  }
}
