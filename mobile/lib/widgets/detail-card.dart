import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line/blocs/affluence/affluence_bloc.dart';
import 'package:line/blocs/geolocate/geolocate_bloc.dart';
import 'package:line/blocs/visit/visit_bloc.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/style/colors.dart';
import 'package:line/widgets/graph.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCard extends StatefulWidget {
  final Shop shop;
  final SharedPreferences prefs;
  const DetailCard({required this.shop, required this.prefs});

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  late bool shopIsFavorite;

  void isFavorite() {
    setState(() {
      shopIsFavorite = false;
    });
    if ((widget.prefs.getStringList("favorites") == null)) {
      return;
    }
    if (widget.prefs
        .getStringList("favorites")!
        .contains(json.encode(widget.shop.toJson())))
      setState(() {
        shopIsFavorite = true;
      });
  }

  String getWaitingTime() {
    return "10 min";
  }

  void saveToFavorite() async {
    if ((widget.prefs.getStringList("favorites") == null) ||
        (widget.prefs.getStringList("favorites")!.isEmpty)) {
      widget.prefs
          .setStringList("favorites", [json.encode(widget.shop.toJson())]);
    } else {
      List<String>? fav = widget.prefs.getStringList("favorites");
      fav!.add(json.encode(widget.shop.toJson()));
      widget.prefs.setStringList("favorites", fav);
    }
    isFavorite();
  }

  void removeFromFavorite() {
    List<String> strings = widget.prefs.getStringList("favorites")!;
    strings.remove(json.encode(widget.shop.toJson()));
    widget.prefs.setStringList("favorites", strings);
    isFavorite();
  }

  @override
  void initState() {
    super.initState();
    isFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
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
            child: Column(
              children: [_getDesc(context), _getBody()],
            )),
      ),
    );
  }

  String getDistance(Position position) {
    double distance = Geolocator.distanceBetween(
            widget.shop.location!["coordinates"][0],
            widget.shop.location!["coordinates"][1],
            position.latitude,
            position.longitude) /
        1000;

    return "A ${distance.toStringAsFixed(1)}KM";
  }

  Widget _getDesc(BuildContext context) {
    GeolocateState geoState = context.watch<GeolocateBloc>().state;
    if (geoState is GeolocateUninitialized) {
      BlocProvider.of<GeolocateBloc>(context).add(GeolocateStart());
    }
    return Row(
      children: [
        Container(
            width: SizeConfig.safeBlockHorizontal * 30,
            child: Image.asset('assets/images/logo.png')),
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
                      if (geoState is GeolocateLoading)
                        CircularProgressIndicator(),
                      if (geoState is GeolocateLoaded)
                        Center(
                          child: Text(
                            getDistance(geoState.position),
                            style: TextStyle(
                                fontFamily: "Baloo",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          shopIsFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: MyTheme.secondaryColor,
                          size: SizeConfig.safeBlockHorizontal * 10,
                        ),
                        onPressed: shopIsFavorite
                            ? removeFromFavorite
                            : saveToFavorite,
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
        hours = widget.shop.hours!['monday'] ?? [];
        break;
      case 2:
        hours = widget.shop.hours!['tuesday'] ?? [];
        break;
      case 3:
        hours = widget.shop.hours!['wednesday'] ?? [];
        break;
      case 4:
        hours = widget.shop.hours!['thursday'] ?? [];
        break;
      case 5:
        hours = widget.shop.hours!['friday'] ?? [];
        break;
      case 6:
        hours = widget.shop.hours!['saturday'] ?? [];
        break;
      case 7:
        hours = widget.shop.hours!['sunday'] ?? [];
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
    AffluenceState affState = context.watch<AffluenceBloc>().state;
    if (affState is AffluenceUninitialized) {
      String shopId = widget.shop.id ?? "";
      BlocProvider.of<AffluenceBloc>(context)
          .add(AffluenceStart(shopId: shopId));
    }
    return Column(
      children: [
        Text(
          "Affluence:",
          style: TextStyle(fontFamily: "Baloo", fontSize: 18),
        ),
        if (affState is AffluenceLoading) CircularProgressIndicator(),
        if (affState is AffluenceLoaded)
          Container(
            padding: EdgeInsets.only(top: 40),
            height: SizeConfig.blockSizeVertical*30,
            child: Graph(
              shop: widget.shop,
            ),
          ),
        if (affState is AffluenceLoaded)
        Text(
          "Temps d'attente estimé : " + affState.waitTime,
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
