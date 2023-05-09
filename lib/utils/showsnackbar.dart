import 'package:flutter/material.dart';
import 'package:instagram_aa/utils/custombutton.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

