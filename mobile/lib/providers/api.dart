import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const Map<String, String> BASE_HEADERS = {
    'Content-Type': 'application/json; charset=utf-8'
  };

  final String authority;
  final String endpoint;
  final String endpointPath;
  final int port;
  http.Client client = http.Client();
  final Uri baseUri;

  Api({
    required this.authority,
    required this.endpoint,
    required this.endpointPath,
    required this.port,
  }) : baseUri = Uri(
            scheme: authority, host: endpoint, port: port, path: endpointPath);

  Future<http.Response> get(String path, {Map<String, String>? query}) async {
    final Uri signedUrl = Uri(
        scheme: authority,
        host: endpoint,
        port: port,
        path: endpointPath + path,
        queryParameters: query);
    http.Response resp = await client.get(
      signedUrl,
    );
    if (resp.statusCode >= 400 && resp.statusCode < 500) {
      throw Exception(resp.body);
    }
    if (resp.statusCode >= 500) {
      throw Exception("[Erreur " +
          resp.statusCode.toString() +
          "] Le serveur a rencontré un problème. Veuillez réessayer.");
    }
    return resp;
  }

  Future<http.Response> post(String path,
      {Map<String, dynamic>? body, Map<String, String>? query}) async {
    try {
      final Uri signedUrl = Uri(
          scheme: authority,
          host: endpoint,
          port: port,
          path: endpointPath + path,
          queryParameters: query);
      http.Response resp = await client.post(
        signedUrl,
        body: json.encode(body),
      );
      if (resp.statusCode >= 400 && resp.statusCode < 500) {
        throw Exception(resp.body);
      }
      if (resp.statusCode >= 500) {
        throw Exception("[Erreur " +
            resp.statusCode.toString() +
            "] Le serveur a rencontré un problème. Veuillez réessayer.");
      }
      return resp;
    } catch (e) {
      throw e;
    }
  }
}
