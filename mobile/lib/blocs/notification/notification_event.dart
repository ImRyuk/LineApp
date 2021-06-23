part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  List<Object> get props => [];
}

class NotificationSuccess extends NotificationEvent {
  final String text;
  const NotificationSuccess(this.text);
  List<Object> get props => [text];
}

class NotificationInfo extends NotificationEvent {
  final String text;
  const NotificationInfo(this.text);
  List<Object> get props => [text];
}

class NotificationError extends NotificationEvent {
  final String text;
  const NotificationError(this.text);
  List<Object> get props => [text];
}