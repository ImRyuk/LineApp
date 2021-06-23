import 'package:flutter/material.dart';
import 'package:line/screens/favorites.dart';
import 'package:line/screens/rewards.dart';
import 'package:line/screens/search.dart';
import 'package:line/style/colors.dart';
import 'package:line/widgets/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final SharedPreferences prefs;

  const Home({required this.prefs});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Widget _getChildren(int index) {
    switch (index) {
      case 0:
        return SearchScreen(widget.prefs);
      case 1:
        return FavoriteScreen(widget.prefs);
      case 2:
        return RewardsScreen(widget.prefs);
      default:
        return SearchScreen(widget.prefs);
    }
  }

    String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Recherche";
      case 1:
        return "Favoris";
      case 2:
        return "Récompenses";
      default:
        return "Recherche";
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(_currentIndex)),
        backgroundColor: MyTheme.primaryColor,
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: Notif(child: _getChildren(_currentIndex)),
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
