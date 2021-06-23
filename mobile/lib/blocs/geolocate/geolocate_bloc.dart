import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line/services/geolocation.dart';


part 'geolocate_event.dart';
part 'geolocate_state.dart';

class GeolocateBloc extends Bloc<GeolocateEvent, GeolocateState> {
  GeolocateBloc() : super(GeolocateUninitialized());

  @override
  Stream<GeolocateState> mapEventToState(GeolocateEvent event) async* {
    final currentState = state;

    if (event is GeolocateStart)
      yield* _mapGeolocateStartToState(currentState, event);
  }

  Stream<GeolocateState> _mapGeolocateStartToState(
    GeolocateState currentState,
    GeolocateStart event,
  ) async* {
    yield GeolocateLoading();
    Position position = await Geolocation.determinePosition();
    yield GeolocateLoaded(position);
  }
}
