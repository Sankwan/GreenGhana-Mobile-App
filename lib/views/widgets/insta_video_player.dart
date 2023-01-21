import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InstaVideoPlayer extends StatefulWidget {
   InstaVideoPlayer({Key? key,this.videoUrl, required this.file}) : super(key: key);
  String? videoUrl;
  File file;

  @override
  State<InstaVideoPlayer> createState() => _InstaVideoPlayerState();
}

class _InstaVideoPlayerState extends State<InstaVideoPlayer> {


   late VideoPlayerController videoPlayerController;
  bool isPaused = true;
  var nextVideo = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((value) {
        videoPlayerController.pause();
        videoPlayerController.setLooping(false);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(  
      children: [
        VisibilityDetector(
          key: Key(widget.videoUrl!),
          onVisibilityChanged: (visibility) {
              if (visibility.visibleFraction == 0 && this.mounted) {
                videoPlayerController.pause();
              }
            },
          child: GestureDetector(
            onTap: () {
              if (videoPlayerController.value.isPlaying) {
                videoPlayerController.pause().then((value) => setState(() {
                      isPaused = true;
                    }));
              } else {
                videoPlayerController.play().then((value) => setState(() {
                      isPaused = false;
                    }));
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:const BoxDecoration(
                  color: Colors.black,
                ),
                child: !videoPlayerController.value.isInitialized
                    ? const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : VideoPlayer(videoPlayerController)),
          ),
        ),
        Visibility(
          visible: isPaused,
          child: Positioned(
            top: 10,
            left: (MediaQuery.of(context).size.width * 0.5) - 260,
            child: GestureDetector(
              onTap: () {
                if (videoPlayerController.value.isPlaying) {
                  videoPlayerController.pause().then((value) => setState(() {
                        isPaused = true;
                      }));
                } else {
                  videoPlayerController.play().then((value) => setState(() {
                        isPaused = false;
                      }));
                }
              },
              child:const SizedBox(
                width: 500,
                height: 500,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white54,
                  size: 100,
                ),
              ),
            ),
          ),
        )
      ],
    
    );
  }
}