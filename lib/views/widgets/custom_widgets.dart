import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

nextNav(BuildContext context, intent) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => intent),
    ),
  );
}

styleButton() {
  return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        const Size(10, 30),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.green));
}

nextNavRemoveHistory(BuildContext context, intent) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => intent),
    (route) => false,
  );
}

prevNav(BuildContext context) {
  Navigator.pop(context);
}

snackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}

var logger = Logger();
