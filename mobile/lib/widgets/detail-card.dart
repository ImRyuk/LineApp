import 'package:flutter/material.dart';
import 'package:line/models/shop.dart';
import 'package:line/services/size_config.dart';

class DetailCard extends StatefulWidget {
  final Shop shop;
  const DetailCard({required this.shop});

  @override
  _DetailCardState createState() => _DetailCardState();
}

bool isFavorite (){

//TODO: faire la fonction qui vérifie dans le local storage si le shop est dans le local storage
  return false;
}

void saveToFavorite(){
  //TODO: faire la fonction qui sauvegarde le shop dans le localstorage
}

class _DetailCardState extends State<DetailCard> {
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
                ),
                IconButton(icon: Icon(isFavorite() ? Icons.favorite : Icons.favorite_border), onPressed: saveToFavorite, )
              ],
            ),
            Text(
              widget.shop.name!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 18),
            ),
            Text(
              widget.shop.type!,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black54, fontSize: 12),
            ),
            Text(
              widget.shop.city!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 12),
            ),
            Text(
              widget.shop.address!,
              style: TextStyle(fontFamily: "Baloo", fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
