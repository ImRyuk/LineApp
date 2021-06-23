import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line/providers/api.dart';
import 'package:line/providers/shop.provider.dart';
import 'package:line/services/geolocation.dart';


part 'affluence_event.dart';
part 'affluence_state.dart';

class AffluenceBloc extends Bloc<AffluenceEvent, AffluenceState> {
  final Api api;
  final ShopProvider shopProvider;
  AffluenceBloc({required this.api, required this.shopProvider}) : super(AffluenceUninitialized());

  @override
  Stream<AffluenceState> mapEventToState(AffluenceEvent event) async* {
    final currentState = state;

    if (event is AffluenceStart)
      yield* _mapAffluenceStartToState(currentState, event);
  }

  Stream<AffluenceState> _mapAffluenceStartToState(
    AffluenceState currentState,
    AffluenceStart event,
  ) async* {
    yield AffluenceLoading();
    dynamic affluences = await shopProvider.getAffluence(event.shopId);
    DateTime now = DateTime.now();
    Map<String,dynamic> results;
      switch (now.weekday) {
        case 1:
          results = affluences['Monday']['Time'];
          break;
        case 2:
          results = affluences['Tuesday']['Time'];//Wednesday
          break;
        case 3:
          results = affluences['Tuesday']['Time'];
          break;
        case 4:
          results = affluences['Thursday']['Time'];
          break;
        case 5:
          results = affluences['Friday']['Time'];
          break;
        case 6:
          results = affluences['Saturday']['Time'];
          break;
        case 7:
          results = affluences['Sunday']['Time'];
          break;
        default:
          results = affluences['Wednesday']['Time'];
          break;
      }
    String hour = now.hour.toString();
    yield AffluenceLoaded(results, (results['$hour']['averageWait'].toString()+"min"));
  }
}
