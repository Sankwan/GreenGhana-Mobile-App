import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/insta_video_player.dart';

//should reflect a preview of the video or picture after it has been taken

class CaptionPostPage extends StatefulWidget {
  const CaptionPostPage({super.key});

  @override
  State<CaptionPostPage> createState() => _CaptionPostPageState();
}

class _CaptionPostPageState extends State<CaptionPostPage> {
  File? image;
  File? video;

//to open camera for images
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageSelected = File(image.path);
      setState(() => this.image = imageSelected);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      snackBar(context, 'Failed to pick image: $e');
    }
  }

//to open camera for videos
  Future pickVideo() async {
    try {
      final video = await ImagePicker().pickVideo(source: ImageSource.camera);
      if (video == null) return;

      final videoSelected = File(video.path);
      setState(() => this.video = videoSelected);
    } on PlatformException catch (e) {
      // print('Failed to pick video: $e');
      snackBar(context, 'Failed to pick video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: 300,
            height: 300,
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                  )
                : const FlutterLogo(size: 300),
          ),
          Container(
            width: 300,
            height: 300,
            child: video != null
                ? InstaVideoPlayer(videoUrl: '')
                : const FlutterLogo(size: 300),
          ),
        ],
      ),
    );
  }
}
