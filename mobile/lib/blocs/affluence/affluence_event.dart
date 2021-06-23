part of 'affluence_bloc.dart';

abstract class AffluenceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AffluenceStart extends AffluenceEvent {
  final String shopId;
  AffluenceStart({required this.shopId});
}
