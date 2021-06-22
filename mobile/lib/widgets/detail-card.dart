import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line/blocs/visit/visit_bloc.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/style/colors.dart';
import 'package:line/widgets/graph.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCard extends StatefulWidget {
  final Shop shop;
  const DetailCard({required this.shop});

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  bool isFavorite() {
//TODO: faire la fonction qui vérifie dans le local storage si le shop est dans le local storage
    return false;
  }

  String getWaitingTime() {
    return "10 min";
  }

  void saveToFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((prefs.getStringList("favorites") == null) ||
        (prefs.getStringList("favorites")!.isEmpty)) {
      prefs.setStringList("favorites", [json.encode(widget.shop.toJson())]);
    } else {
      List<String>? fav = prefs.getStringList("favorites");
      fav!.add(json.encode(widget.shop.toJson()));
      prefs.setStringList("favorites", fav);
    }
  }

  void removeFromFavorite() {
    //TODO: faire la fonction qui retire le shop dans le localstorage
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 80,
      padding: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, 2))
              ]),
          child: ListView(
            children: [_getDesc(), _getBody()],
          )),
    );
  }

  Widget _getDesc() {
    return Row(
      children: [
        Container(
            width: SizeConfig.safeBlockHorizontal * 30,
            child: Image.asset('assets/images/carrefour.png')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal * 45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shop.name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "Baloo", fontSize: 24),
                      ),
                      Text(
                        widget.shop.type!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "Baloo",
                            color: Colors.black54,
                            fontSize: 12),
                      ),
                      Text(
                        widget.shop.location!["city"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "Baloo", fontSize: 12),
                      ),
                      Text(
                        widget.shop.location!["streetNumber"] +
                            " " +
                            widget.shop.location!["streetName"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "Baloo", fontSize: 12),
                      )
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "A 5.2KM",
                          style: TextStyle(
                              fontFamily: "Baloo",
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite() ? Icons.favorite : Icons.favorite_border,
                          color: MyTheme.secondaryColor,
                          size: SizeConfig.safeBlockHorizontal * 10,
                        ),
                        onPressed: saveToFavorite,
                      )
                    ],
                  ),
                )
              ],
            ),
            _getOpen(),
            _getReward()
          ],
        ),
      ],
    );
  }

  Widget _getOpen() {
    DateTime now = DateTime.now();
    List<dynamic> hours;
    switch (now.weekday) {
      case 1:
        hours = widget.shop.hours!['monday'];
        break;
      case 2:
        hours = widget.shop.hours!['tuesday'];
        break;
      case 3:
        hours = widget.shop.hours!['wednesday'];
        break;
      case 4:
        hours = widget.shop.hours!['thursday'];
        break;
      case 5:
        hours = widget.shop.hours!['friday'];
        break;
      case 6:
        hours = widget.shop.hours!['saturday'];
        break;
      case 7:
        hours = widget.shop.hours!['sunday'];
        break;
      default:
        hours = [];
        break;
    }
    if (hours.length == 0)
      return Text("Actuellement ouvert - ferme à 22h",
          style: TextStyle(
              fontFamily: "Baloo", fontSize: 14, color: Colors.green));
    if (hours.length == 2) {
      if (now.hour >= hours[0] && now.hour < hours[1]) {
        return Text('Actuellement ouvert - ferme à ${hours[1]}h',
            style: TextStyle(
                fontFamily: "Baloo", fontSize: 14, color: Colors.green));
      } else {
        return Text('Actuellement fermé',
            style: TextStyle(
                fontFamily: "Baloo", fontSize: 14, color: Colors.red));
      }
    }
    if (hours.length == 4) {
      if ((now.hour >= hours[0] && now.hour < hours[1]) ||
          (now.hour >= hours[2] && now.hour < hours[3])) {
        return Text('Actuellement ouvert - ferme à ${hours[3]}h',
            style: TextStyle(
                fontFamily: "Baloo", fontSize: 14, color: Colors.green));
      } else {
        return Text('Actuellement fermé',
            style: TextStyle(
                fontFamily: "Baloo", fontSize: 14, color: Colors.red));
      }
    } else
      return Container();
  }

  Widget _getReward() {
    if ((widget.shop.reward == null) || (widget.shop.reward == ""))
      return Container();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.secondaryColor),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.gift,
            color: MyTheme.darkPurple,
          ),
          Text("Ce magasin offre des récompenses",
              style: TextStyle(
                  fontFamily: "Baloo",
                  fontSize: 12,
                  color: MyTheme.secondaryColor)),
        ],
      ),
    );
  }

  Widget _getBody() {
    VisitState visitState = context.watch<VisitBloc>().state;
    return Column(
      children: [
        Text(
          "Affluence:",
          style: TextStyle(fontFamily: "Baloo", fontSize: 18),
        ),
        Graph(
          shop: widget.shop,
        ),
        Text(
          "Temps d'attente estimé : " + getWaitingTime(),
          style: TextStyle(fontFamily: "Baloo", fontSize: 18),
        ),
        TextButton(
            onPressed: () {
              visitState is VisitStarted
                  ? BlocProvider.of<VisitBloc>(context)
                      .add(VisitFinish(visit: visitState.visit))
                  : BlocProvider.of<VisitBloc>(context)
                      .add(VisitStart(widget.shop));
            },
            child: Container(
              width: SizeConfig.safeBlockHorizontal * 75,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: MyTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Center(
                child: Text(
                  visitState is VisitStarted ? "Je suis parti" : "Je suis là",
                  style: TextStyle(
                      fontFamily: "Baloo", fontSize: 24, color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
