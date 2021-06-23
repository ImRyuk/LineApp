part of 'geolocate_bloc.dart';

abstract class GeolocateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GeolocateStart extends GeolocateEvent {

  GeolocateStart();
}
