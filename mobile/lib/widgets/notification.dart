import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:line/blocs/notification/notification_bloc.dart';

class Notif extends StatelessWidget {
  final Color successColor;
  final Color errorColor;
  final Color infoColor;
  final Widget child;

  const Notif({
    required this.child,
    this.successColor = Colors.green,
    this.errorColor = Colors.red,
    this.infoColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (BuildContext context, NotificationState state) {
        if (state is NotificationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: successColor,
              content: Text(state.text),
            ),
          );
        }
        if (state is NotificationInfoState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: infoColor,
              content: Text(state.text),
            ),
          );
        }
        if (state is NotificationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: errorColor,
              content: Text(state.text),
            ),
          );
        }
      },
      child: child,
    );
  }
}