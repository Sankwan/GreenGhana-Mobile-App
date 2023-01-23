// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/provider/add_post_provider.dart';
import 'package:instagram_aa/utils/custombutton.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/widgets/form_input_builder.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../utils/custom_theme.dart';
import '../widgets/custominputfield.dart';
import '../widgets/dottedContainer.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  ImagePicker picker = ImagePicker();

  VideoPlayerController? _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    AddPostProvider pro = context.read<AddPostProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        title: const Text("Add Drug", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Text(
            'Add caption',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          FormInputBuilder(
            hintText: '...',
            maxlines: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          DottedContainer(
            childwidget: GestureDetector(
              onTap: () => pickImage(context),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade300),
                    child: const Center(
                      child: Icon(
                        Icons.file_present_outlined,
                        // size: 22,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Tap to add video",
                    style: subtitlestlye.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomButton(onpress: () {}, label: 'Upload'),
          const SizedBox(
            height: 16,
          ),
          pro.videoFile != null
              ? _videoPlayerController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }

  Future pickImage(BuildContext context) async {
    AddPostProvider pro = context.read<AddPostProvider>();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      pro.setVideoFile(pickedFile);

      _videoPlayerController = VideoPlayerController.file(pro.videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController?.play();
        });
      // if (tag == 'front') {
      //   av.setimageOfNationlIDFront(pickedFile);
      // } else if (tag == 'back') {
      //   av.setimageOfNationalIdBack(pickedFile);
    } else {
      showSnackBar(context, 'No image selected');
    }
  }
}
