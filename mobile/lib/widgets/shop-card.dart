import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line/blocs/affluence/affluence_bloc.dart';
import 'package:line/blocs/geolocate/geolocate_bloc.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/widgets/detail-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopCard extends StatelessWidget {
  final SharedPreferences prefs;
  final Shop shop;
  const ShopCard({required this.shop, required this.prefs});

  String getDistance(Position position) {
    double distance = Geolocator.distanceBetween(
            shop.location!["coordinates"][0],
            shop.location!["coordinates"][1],
            position.latitude,
            position.longitude) /
        1000;

    return "A ${distance.toStringAsFixed(1)}KM";
  }

  @override
  Widget build(BuildContext context) {
    GeolocateState geoState = context.watch<GeolocateBloc>().state;
    if (geoState is GeolocateUninitialized) {
      BlocProvider.of<GeolocateBloc>(context).add(GeolocateStart());
    }
    return Container(
      width: SizeConfig.safeBlockHorizontal * 50,
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          String shopId = shop.id ?? "";
          BlocProvider.of<AffluenceBloc>(context)
              .add(AffluenceStart(shopId: shopId));
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return DetailCard(shop: shop, prefs: prefs);
              });
        },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      width: SizeConfig.safeBlockHorizontal * 20,
                      child: Image.asset('assets/images/logo.png')),
                  if (geoState is GeolocateLoading) CircularProgressIndicator(),
                  if (geoState is GeolocateLoaded)
                    Center(
                      child: Text(
                        getDistance(geoState.position),
                        style: TextStyle(
                            fontFamily: "Baloo",
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockVertical * 2),
                      ),
                    ),
                ],
              ),
              Text(
                shop.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Baloo",
                    fontSize: SizeConfig.safeBlockVertical * 3),
              ),
              Text(
                shop.type!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.black54,
                    fontSize: SizeConfig.safeBlockVertical * 2),
              ),
              Text(
                shop.location!["city"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Baloo",
                    fontSize: SizeConfig.safeBlockVertical * 2),
              ),
              Text(
                shop.location!["streetNumber"] +
                    " " +
                    shop.location!["streetName"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Baloo",
                    fontSize: SizeConfig.safeBlockVertical * 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
