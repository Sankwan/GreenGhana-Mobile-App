import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    ),
    padding: EdgeInsets.all(10),
    duration: Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {},
    ),
  ));
}
