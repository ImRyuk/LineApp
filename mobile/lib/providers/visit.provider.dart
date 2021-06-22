import 'package:line/models/visit.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

class VisitProvider {
  static const String path = '/visits';
  final Api api;
  const VisitProvider({required this.api});

  void saveVisit(Visit visit) async {
    print(visit);
    final http.Response response = await api.post(path, body: visit.toJson());
    print(response.body);
  }
}
