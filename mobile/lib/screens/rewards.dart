import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/widgets/reward-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const RewardsScreen(this.prefs);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final searchController = TextEditingController();

  List<Shop> getRewards() {
    List<String>? rewards = widget.prefs.getStringList("rewards");
    List<Shop> shops = [];
    rewards!.forEach((rew) {
      shops.add(Shop.fromJson(json.decode(rew)));
    });
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
              children: getRewards()
                  .map((shop) => RewardCard(
                        shop: shop,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
