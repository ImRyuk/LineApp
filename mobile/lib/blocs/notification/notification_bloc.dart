import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NotificationSuccess) {
      yield NotificationSuccessState(event.text);
    }
    if (event is NotificationInfo) {
      yield NotificationInfoState(event.text);
    }
    if (event is NotificationError) {
      yield NotificationErrorState(event.text);
    }
    await Future.delayed(Duration(seconds: 2));
    yield* _mapToInitial();
  }

  Stream<NotificationState> _mapToInitial() async* {
    yield NotificationInitial();
  }
}
