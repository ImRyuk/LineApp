part of 'geolocate_bloc.dart';

abstract class GeolocateState extends Equatable {
  const GeolocateState();

  @override
  List<Object> get props => [];
}

class GeolocateUninitialized extends GeolocateState {
  GeolocateUninitialized();

  @override
  String toString() => 'GeolocateUninitialized';
}

class GeolocateLoading extends GeolocateState {
  GeolocateLoading();

  @override
  String toString() => 'GeolocateLoading';
}

class GeolocateLoaded extends GeolocateState {
  final Position position;
  GeolocateLoaded(this.position);

  @override
  String toString() => 'GeolocateLoaded';
}
