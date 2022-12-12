import 'package:flutter/material.dart';

class VideoIcon extends StatelessWidget {
  final String videourl;
  final double iconSize;
  const VideoIcon({Key? key, required this.videourl, required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videourl == "") {
      return Container();
    } else {
      return Align(
        alignment: Alignment.center,
        child: Icon(Icons.play_circle_fill_outlined,
            color: Colors.white, size: iconSize),
      );
    }
  }
}
