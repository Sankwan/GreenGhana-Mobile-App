import 'package:flutter/cupertino.dart';

void nextScreen(BuildContext ctx, Route route) {
  Navigator.of(ctx).push(route);
}

void nextScreenClosePrev(BuildContext ctx, Route route) {
  Navigator.of(ctx).pushReplacement(route);
}

void closeUI(BuildContext context) {
  Navigator.pop(context);
}

void nextscreenRemovePredicate(BuildContext context, Route route) {
  Navigator.pushAndRemoveUntil(
    context,
    route,
    (Route<dynamic> route) => false,
  );
}


