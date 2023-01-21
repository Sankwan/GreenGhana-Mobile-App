// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_aa/provider/add_post_provider.dart';
// import 'package:instagram_aa/utils/showsnackbar.dart';
// import 'package:instagram_aa/views/widgets/custom_widgets.dart';
// import 'package:instagram_aa/views/widgets/customtextformfield.dart';
// import 'package:instagram_aa/views/widgets/insta_video_player.dart';
// import 'package:instagram_aa/views/widgets/video_player_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class AddPostPage extends StatefulWidget {
//   const AddPostPage({super.key});

//   @override
//   State<AddPostPage> createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddPostPage> {
//

//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<AddPostProvider>();
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,

// body:
//           : ListView(
//
//               children: [

// :
//               ],
//             ),
//     );
//   }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:instagram_aa/provider/add_post_provider.dart';
import 'package:instagram_aa/views/widgets/customtextformfield.dart';
import 'package:instagram_aa/views/widgets/insta_video_player.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<SelectedByte> listOfSelectedByte = [];
  @override
  Widget build(BuildContext context) {
    final p = context.watch<AddPostProvider>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            // Container(
            //     margin: const EdgeInsets.all(10),
            //     child: FloatingActionButton(
            //       onPressed: () {
            //         pickVideo();
            //       },
            //       child: const Icon(Icons.video_camera_back),
            //     )),
            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    pickImage(context);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                          child: InstaVideoPlayer(file: p.selectedPostVideo!)),
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
              ));
  }

  Future pickImage(BuildContext context) async {
    // final p = await _picker.pickImage(source: ImageSource.gallery);
    // final pp = context.read<AddPostProvider>();
    // if (p != null) {
    //   pp.setPostImage(p);
    // } else {
    //   showSnackBar(context, 'No Image Captured');
    // }

    ImagePickerPlus pickerPlus = ImagePickerPlus(context);
    SelectedImagesDetails? det = await pickerPlus.pickImage(
        source: ImageSource.both,
        multiImages: true,
        galleryDisplaySettings: GalleryDisplaySettings(
          showImagePreview: true,
        ));
    if (det != null) {
      listOfSelectedByte.addAll(det.selectedFiles);
      setState(() {});
    }
  }

// //to open camera for videos
//   Future pickVideo() async {
//     final pv = await _picker.pickVideo(source: ImageSource.gallery);
//     final pp = context.read<AddPostProvider>();
//     if (pv != null) {
//       pp.setPostVideo(pv);
//     } else {
//       showSnackBar(context, 'No video selected');
//     }
//   }
}

// ImagePickerPlus picker = ImagePickerPlus(context);
//     SelectedImagesDetails? details = await picker.pickBoth(
//         source: ImageSource.both,
//         multiSelection: true,
//         galleryDisplaySettings:
//             GalleryDisplaySettings(cropImage: true, showImagePreview: true));
//     if (details != null) {
//       listOfSelectedByte.addAll(details.selectedFiles);
//       setState(() {});
//     }
