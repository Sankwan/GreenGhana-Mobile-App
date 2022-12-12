import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram_aa/theme/colors.dart';

class SplashLoader extends StatelessWidget {
  const SplashLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(color: Colors.green, size: 28);
  }
}

class StatusProgressLoader extends StatelessWidget {
  const StatusProgressLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SpinKitFadingCircle(color: dapsColor, size: 35);
  }
}
