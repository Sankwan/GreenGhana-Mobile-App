import 'dart:math';

import 'package:flutter/material.dart';

const borderColor = Colors.grey;
// const iconColor = Colors.black54;

// getRandomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];
