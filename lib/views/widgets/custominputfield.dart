import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Widget childwidget;
  const CustomInputField({super.key, required this.childwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: childwidget,
    );
  }
}
