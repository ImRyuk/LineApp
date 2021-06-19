import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line/blocs/search/search_bloc.dart';
import 'package:line/services/size_config.dart';
import 'package:line/style/colors.dart';
import 'package:line/widgets/shop-card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SearchState searchState = context.watch<SearchBloc>().state;
    return Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0x66D4D4D4),
                  borderRadius: BorderRadius.circular(20)),
              width: SizeConfig.safeBlockHorizontal * 80,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Rechercher"),
                onSubmitted: (text) => BlocProvider.of<SearchBloc>(context)
                    .add(SearchLaunch(searchController.text)),
              ),
            ),
            if (searchState is SearchLoaded)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: searchState.shops
                      .map((shop) => ShopCard(
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
