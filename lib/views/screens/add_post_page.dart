// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/provider/add_post_provider.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/customtextformfield.dart';
import 'package:instagram_aa/views/widgets/insta_video_player.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // File? image;
  // File? video;
  final ImagePicker _picker = ImagePicker();

//to open camera for images

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AddPostProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.vertical, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  pickVideo();
                },
                child: const Icon(Icons.video_camera_back),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  pickImage();
                },
                child: const Icon(Icons.camera_alt),
              )),
        ],
      ),
      body: p.selectedPostImage == null && p.selectedPostVideo == null
          ? const Center(
              child: Text(
                "Select video or image to upload",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                p.selectedPostImage != null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: .5, color: Colors.blueGrey.shade200),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.file(
                          p.selectedPostImage!,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 5.0,
                              ),
                            ],
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8)),
                        // child: Image.asset(
                        //   "assets/images/profilepic1.jpg",
                        //   fit: BoxFit.contain,
                        // ),
                        child: InstaVideoPlayer(videoUrl: ""),
                      ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hinttext: 'Add Caption',
                  label: "Add Caption",
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hinttext: 'Location',
                  label: "Location",
                ),
              ],
            ),
    );
  }

  Future pickImage() async {
    final pf = await _picker.pickImage(source: ImageSource.camera);
    final pp = context.read<AddPostProvider>();
    if (pf != null) {
      pp.setPostImage(pf);
    } else {
      showSnackBar(context, 'No Image Captured');
    }
  }

//to open camera for videos
  Future pickVideo() async {
    final pv = await _picker.pickVideo(source: ImageSource.gallery);
    final pp = context.read<AddPostProvider>();
    if (pv != null) {
      pp.setPostVideo(pv);
    } else {
      showSnackBar(context, 'No video selected');
    }
  }
}
