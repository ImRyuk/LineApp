part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  final String text;

  const NotificationState(this.text);
  List<Object> get props => [text];
}

class NotificationInitial extends NotificationState {
  NotificationInitial() : super("");
}

class NotificationSuccessState extends NotificationState {
  const NotificationSuccessState(text) : super(text);
  @override
  String toString() => 'NotificationSuccessState { $text }';
}

class NotificationInfoState extends NotificationState {
  const NotificationInfoState(text) : super(text);
  @override
  String toString() => 'NotificationInfoState { $text }';
}

class NotificationErrorState extends NotificationState {
  const NotificationErrorState(text) : super(text);
  @override
  String toString() => 'NotificationErrorState { $text }';
}
