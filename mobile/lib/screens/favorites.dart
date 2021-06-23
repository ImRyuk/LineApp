import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/widgets/shop-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const FavoriteScreen(this.prefs);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final searchController = TextEditingController();

  List<Shop> getFavorites() {
    List<Shop> shops = [];
    if (widget.prefs.getStringList("favorites") != null) {
      List<String>? favs = widget.prefs.getStringList("favorites");
      favs!.forEach((fav) {
        shops.add(Shop.fromJson(json.decode(fav)));
      });
    }
    return shops;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: getFavorites()
                  .map((shop) => ShopCard(
                        shop: shop,
                        prefs: widget.prefs,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
