part of 'visit_bloc.dart';

abstract class VisitState extends Equatable {
  const VisitState();

  @override
  List<Object> get props => [];
}

class VisitUninitialized extends VisitState {
  VisitUninitialized();

  @override
  String toString() => 'VisitUninitialized';
}

class VisitStarted extends VisitState {
  final Visit visit;
  VisitStarted({required this.visit});

  @override
  String toString() => 'VisitStarted';
}

class VisitFinished extends VisitState {
  VisitFinished();

  @override
  String toString() => 'VisitFinished';
}
