part of 'visit_bloc.dart';

abstract class VisitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VisitStart extends VisitEvent {
  final Shop shop;

  VisitStart(this.shop);
}

class VisitFinish extends VisitEvent {
  final Visit visit;

  VisitFinish({required this.visit});
}
