import 'package:flutter/widgets.dart';

class FadeAnimate extends PageRouteBuilder {
  final Widget page;
  FadeAnimate(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1900),
            transitionsBuilder:
                (context, animation, secondaryanimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return FadeTransition(opacity: animation, child: page);
            });
}
