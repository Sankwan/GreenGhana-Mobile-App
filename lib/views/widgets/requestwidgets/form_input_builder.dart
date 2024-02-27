// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputBuilder extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const FormInputBuilder({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        contentPadding: const EdgeInsets.only(
          left: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 12,
        ),
      ),
    );
  }
}
