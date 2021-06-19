import 'package:flutter/material.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';

class DetailCard extends StatelessWidget {
  final Shop shop;
  const DetailCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 100,
      //height: MediaQuery.of(context).size.height / 5,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal * 25,
                  child: Image.asset('assets/images/carrefour.png')),
                Text(
                  "A 5.2KM",
                  style: TextStyle(
                      fontFamily: "Baloo",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
            Text(
              shop.name!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 18),
            ),
            Text(
              shop.type!,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black54, fontSize: 12),
            ),
            Text(
              shop.city!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 12),
            ),
            Text(
              shop.address!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
