import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line/models/shop.dart';
import 'package:line/models/visit.dart';
import 'package:line/providers/visit.provider.dart';
import 'package:line/services/geolocation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/api.dart';

part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final Api api;
  final VisitProvider visitProvider;
  VisitBloc({required this.api, required this.visitProvider})
      : super(VisitUninitialized());

  @override
  Stream<VisitState> mapEventToState(VisitEvent event) async* {
    final currentState = state;

    if (event is VisitStart) yield* _mapVisitStartToState(currentState, event);
    if (event is VisitFinish)
      yield* _mapVisitFinishToState(currentState, event);
  }

  Stream<VisitState> _mapVisitStartToState(
    VisitState currentState,
    VisitStart event,
  ) async* {
    Position pos = await Geolocation.determinePosition();
    double shopLat = event.shop.location!["coordinates"][0];
    double shopLong = event.shop.location!["coordinates"][1];

    if (Geolocator.distanceBetween(
            shopLat, shopLong, pos.latitude, pos.longitude) <=
        50000) {
      if (event.shop.reward != null && event.shop.reward != "") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if ((prefs.getStringList("rewards") == null) ||
            (prefs.getStringList("rewards")!.isEmpty)) {
          prefs.setStringList("rewards", [json.encode(event.shop.toJson())]);
        } else {
          List<String>? rewards = prefs.getStringList("rewards");
          rewards!.add(json.encode(event.shop.toJson()));
          prefs.setStringList("rewards", rewards);
        }
      }
      Visit visit = Visit(shopId: event.shop.id, startDate: pos.timestamp);
      yield VisitStarted(visit: visit);
    } else {
      yield VisitUninitialized();
      throw Exception("Distance trop elevée");
    }
  }

  Stream<VisitState> _mapVisitFinishToState(
    VisitState currentState,
    VisitFinish event,
  ) async* {
    Position pos = await Geolocation.determinePosition();
    Visit visit = event.visit.copyWith(endDate: pos.timestamp);
    //verif qu'on a quitte la geoloc toutes les 30 secs
    visitProvider.saveVisit(visit);
    yield VisitFinished();
  }
}
