import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedContainer extends StatelessWidget {
  final Widget childwidget;
  const DottedContainer({super.key, required this.childwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: .5,
        dashPattern: const [10, 6],
        radius: const Radius.circular(8),
        child: childwidget
      ),
    );
  }
}
