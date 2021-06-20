import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:line/models/shop.dart';

import 'api.dart';

class ShopProvider {
  static const String path = '/shops';
  final Api api;
  const ShopProvider({required this.api});

  Future<List<Shop>> getManyFromKeyword(String search) async {
    try {
      Response response = await this.api.get(path);
      print(response.body);
      return _convertRawListToObject(response);
    } catch (e) {
      print(e);
      throw Exception("Erreur de chargement des shop");
    }
  }

  List<Shop> _convertRawListToObject(http.Response response) {
    return (json.decode(response.body) as List)
        .map((i) => Shop.fromJson(i))
        .toList();
  }
}
