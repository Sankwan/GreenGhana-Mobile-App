
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TikTokVideoPlayer extends StatefulWidget {
  TikTokVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);
  String videoUrl;

  @override
  State<TikTokVideoPlayer> createState() => _TikTokVideoPlayerState();
}

class _TikTokVideoPlayerState extends State<TikTokVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool isPaused = true;
  var nextVideo = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
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
          key: Key(widget.videoUrl),
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
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: !videoPlayerController.value.isInitialized
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
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
            top: 0,
            bottom: 0,
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
              child: SizedBox(
                width: 500,
                height: 500,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.grey,
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
