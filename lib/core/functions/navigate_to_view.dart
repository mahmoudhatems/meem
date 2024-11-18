import 'package:flutter/material.dart';

Future navigateToView(BuildContext context, {required String route}) =>
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
    );

dynamic backToPrevious(BuildContext context) => Navigator.pop(context);
