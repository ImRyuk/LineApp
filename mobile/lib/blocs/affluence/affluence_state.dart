part of 'affluence_bloc.dart';

abstract class AffluenceState extends Equatable {
  const AffluenceState();

  @override
  List<Object> get props => [];
}

class AffluenceUninitialized extends AffluenceState {
  AffluenceUninitialized();

  @override
  String toString() => 'AffluenceUninitialized';
}

class AffluenceLoading extends AffluenceState {
  AffluenceLoading();

  @override
  String toString() => 'AffluenceLoading';
}

class AffluenceLoaded extends AffluenceState {
  final Map<String,dynamic> affluences;
  final String waitTime;
  AffluenceLoaded(this.affluences, this.waitTime);

  @override
  String toString() => 'AffluenceLoaded';
}
