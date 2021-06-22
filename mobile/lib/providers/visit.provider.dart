import 'package:line/models/visit.dart';
import 'api.dart';

class VisitProvider {
  static const String path = '/visits';
  final Api api;
  const VisitProvider({required this.api});

  void saveVisit(Visit visit) async {
    await api.post(path, body: visit.toJson());
  }
}
