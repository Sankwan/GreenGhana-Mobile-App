import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

showProgressLoader() {
  BotToast.showLoading(
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.ignore,
      align: Alignment.center);
}

cancelProgressLoader() {
  BotToast.closeAllLoading();
}

Widget imagePlaceholder() {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF1F4F8)
              ),
          alignment: const AlignmentDirectional(0, 0),
        )),
  );
}
