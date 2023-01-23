import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/animation/video_controller.dart';
import 'package:instagram_aa/models/video.dart';
import 'package:instagram_aa/services/firebase_service.dart';

// class VideoProvider with ChangeNotifier {
//   final videoControl = VideoControllerImplement();
//   List<Video> _videos = [];

//   UnmodifiableListView<Video> get videos => UnmodifiableListView(_videos);

//   Future loadVideos() async {
//     final v = await videoControl.getAllVideos();
//     _videos = v;
//     logs.d(_videos.length);
//     notifyListeners();
//   }
// }
