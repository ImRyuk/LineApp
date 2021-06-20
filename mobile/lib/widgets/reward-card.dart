import 'package:flutter/material.dart';
import 'package:line/models/reward.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';
import 'package:line/widgets/detail-card.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final Shop shop;
  const RewardCard({required this.reward, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 50,
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return DetailCard(shop: shop);
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
                shop.location!["city"],
                style: TextStyle(fontFamily: "Baloo", fontSize: 12),
              ),
              Text(
                shop.location!["streetNumber"] + " " + shop.location!["streetName"],
                style: TextStyle(fontFamily: "Baloo", fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
