import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:line/models/shop.dart';

import '../../providers/api.dart';

part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final Api api;
  VisitBloc({required this.api}) : super(VisitUninitialized());

  @override
  Stream<VisitState> mapEventToState(VisitEvent event) async* {
    final currentState = state;

    if (event is VisitStart)
      yield* _mapVisitStartToState(currentState, event);
  }

  Stream<VisitState> _mapVisitStartToState(
    VisitState currentState,
    VisitStart event,
  ) async* {
    //verif geoloc
    yield VisitStarted();
    //verif qu'on quitte la geoloc toutes les 30 secs
    await Future.delayed(const Duration(seconds: 2));
    //envoi de la visite au serveur
    yield VisitFinished();
  }
}
