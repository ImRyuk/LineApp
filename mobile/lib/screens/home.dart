import 'package:flutter/material.dart';
import 'package:line/screens/rewards.dart';
import 'package:line/screens/search.dart';
import 'package:line/style/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SearchScreen(),
    RewardsScreen(),
    RewardsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Recherche"),
        backgroundColor: MyTheme.primaryColor,
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF000000),
        unselectedItemColor: Color(0xFF999999),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Recherche"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Récompenses")
        ],
      ),
    ));
  }
}
