import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:src/pages/HomePage/NotesPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [
    NotesPage(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PersistentTabView(context, screens: screens, items: [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note),
        title: ("Notes"),
        activeColorPrimary: Colors.blue, 
        inactiveColorPrimary: Colors.grey,
      ), 
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.green, 
        inactiveColorPrimary: Colors.grey,
      )
    ],));
  }
}
