// ignore_for_file: use_build_context_synchronously, library_prefixes
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/provider/add_post_provider.dart';
import 'package:instagram_aa/utils/custombutton.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/post_controller.dart';
import '../../provider/userprovider.dart';
import '../../utils/custom_theme.dart';
import '../widgets/dottedContainer.dart';
import '../widgets/requestwidgets/form_input_builder.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  ImagePicker picker = ImagePicker();

  VideoPlayerController? _videoPlayerController;

  late TextEditingController captionController;
  PostControllerImplement controller = PostControllerImplement();

  @override
  void initState() {
    captionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddPostProvider pro = context.read<AddPostProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: .5,
        title: const Text("Post video", style: TextStyle(color: Colors.black, fontSize: 15),),
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
            controller: captionController,
          ),
          const SizedBox(
            height: 16,
          ),
          DottedContainer(
            childwidget: GestureDetector(
              onTap: () => pickImage(context),
              child: Center(
                child: pro.videoFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300),
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
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Center(
                              child: Icon(
                                Icons.video_file_rounded,
                                size: 35,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              Path.basename(pro.videoFile!.path),
                              textAlign: TextAlign.center,
                              style: subtitlestlye.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomButton(onpress: () => uploadVideoPost(), label: 'Upload'),
        ],
      ),
    );
  }

  Future pickImage(BuildContext context) async {
    AddPostProvider pro = context.read<AddPostProvider>();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pro.setVideoFile(pickedFile);
      });
      // _videoPlayerController = VideoPlayerController.file(pro.videoFile!)
      //   ..initialize().then((_) {
      //     setState(() {});
      //     _videoPlayerController?.play();
      //   });
    } else {
      showSnackBar(context, 'No video selected');
    }
  }

  void uploadVideoPost() async {
    final p = context.read<UserProvider>();
    AddPostProvider pro = context.read<AddPostProvider>();

    if (captionController.text.isEmpty) {
      return showSnackBar(context, 'video caption is required');
    }

    showProgressLoader();
    if (pro.videoFile == null) {
      cancelProgressLoader();
      return showSnackBar(context, 'Select video to upload');
    }
    String? videoUrl = await controller.getDownloadUrl(
      pro.videoFile!,
      "posts/${Path.basename(pro.videoFile!.path)}",
    );
    bool isPosted = await controller.addPost(
        post: PostsModel(
      userName: p.usermodel.userName,
      videoUrl: videoUrl,
      imageUrl: [],
      likes: [],
      userAvatar: p.usermodel.avatar ?? p.usermodel.userName,
      caption: captionController.text.toString(),
      datePublished: DateTime.now().toString(),
      longitude: p.longitude,
      latitude: p.latitude,
    ));

    if (isPosted) {
      cancelProgressLoader();
      showSnackBar(context, 'Post submitted');
      captionController.clear();
      setState(() {
        pro.clearImage();
      });
    } else {
      cancelProgressLoader();
      showSnackBar(context, 'Error! something went wrong');
    }
  }
}
