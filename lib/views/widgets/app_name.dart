import 'package:flutter/material.dart';
class AppName extends StatelessWidget {
  final double fontSize;
  final String title;
  final String span;
  const AppName(
      {Key? key,
      required this.fontSize,
      required this.title,
      required this.span})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title, //first part
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).primaryColor),
        children: <TextSpan>[
          TextSpan(
              text: span, //second part
              style: const TextStyle(fontFamily: 'Poppins', color: Colors.lightGreen)),
        ],
      ),
    );
  }
}
