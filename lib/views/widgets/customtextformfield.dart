import 'package:flutter/material.dart';
import 'package:instagram_aa/utils/custom_theme.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  final String hinttext;
  final String label;
  TextInputType? keybaordtype;
  CustomTextFormField(
      {super.key,
      this.controller,
      required this.hinttext,
      this.keybaordtype,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: .5)),
          child: TextFormField(
            controller: controller,
            autofocus: false,
            keyboardType: keybaordtype,
            style: subtitlestlye.copyWith(
                color: Theme.of(context).colorScheme.primary),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              hintText: hinttext,
              border: InputBorder.none,
              hintStyle: subtitlestlye.copyWith(
                  fontSize: 12, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      ],
    );
  }
}
