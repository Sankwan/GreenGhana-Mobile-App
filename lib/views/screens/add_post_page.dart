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

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/provider/add_post_provider.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/upload_video_page.dart';
import 'package:instagram_aa/views/widgets/customtextformfield.dart';
import 'package:instagram_aa/views/widgets/insta_video_player.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_theme.dart';
import '../widgets/form_input_builder.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  List<File> imagesList = [];
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AddPostProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        title: const Text("Add Post", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.upload,
              size: 26,
            ),
          )
        ],
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(12),
            child: FloatingActionButton(
              onPressed: () {
                // pickImage(context);
                nextScreen(context, SlideAnimate(const UploadVideoPage()));
              },
              child: const Icon(Icons.video_camera_back_outlined),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            'Add caption',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FormInputBuilder(
            hintText: '...',
            maxlines: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: imagesList.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      strokeWidth: .5,
                      dashPattern: const [10, 6],
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              imagesList.length > 2
                                  ? showSnackBar(context, 'muliple image limit')
                                  : pickImage(context);
                            },
                            icon: const Icon(Icons.add_a_photo)),
                      ))
                  : Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            image: DecorationImage(
                              image: FileImage(
                                imagesList[index - 1],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imagesList.removeAt(index - 1);
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ],
      ),

      // body: p.selectedPostImage == null && p.selectedPostVideo == null
      //     ? const Center(
      //         child: Text(
      //           "Select video or image to upload",
      //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      //         ),
      //       )
      //     : ListView(
      //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //         children: [
      //           p.selectedPostImage != null
      //               ? Container(
      //                   height: 200,
      //                   width: double.infinity,
      //                   decoration: BoxDecoration(
      //                       border: Border.all(
      //                           width: .5, color: Colors.blueGrey.shade200),
      //                       color: Colors.grey.shade100,
      //                       borderRadius: BorderRadius.circular(8)),
      //                   child: Image.file(
      //                     p.selectedPostImage!,
      //                     fit: BoxFit.contain,
      //                   ),
      //                 )
      //               : Container(
      //                   height: 200,
      //                   width: double.infinity,
      //                   decoration: BoxDecoration(
      //                       boxShadow: const [
      //                         BoxShadow(
      //                           color: Colors.grey,
      //                           offset: Offset(0, 1),
      //                           blurRadius: 5.0,
      //                         ),
      //                       ],
      //                       color: Colors.grey.shade300,
      //                       borderRadius: BorderRadius.circular(8)),
      //                   child: InstaVideoPlayer(file: p.selectedPostVideo!)),
      //           const SizedBox(height: 16),
      //           CustomTextFormField(
      //             hinttext: 'Add Caption',
      //             label: "Add Caption",
      //           ),
      //           const SizedBox(height: 16),
      //           CustomTextFormField(
      //             hinttext: 'Location',
      //             label: "Location",
      //           ),
      //         ],
      //       ),
    );
  }

  Future pickImage(BuildContext context) async {
    final log = Logger();
    final selectedImages = await picker.pickMultiImage();
    try {
      if (selectedImages.length < 4) {
        for (var image in selectedImages) {
          setState(() {
            imagesList.add(File(image.path));
          });
        }
      } else {
        showSnackBar(context, 'You have reach your limit');
      }
    } catch (e) {
      log.d(e);
    }
    selectedImages.isEmpty ? retrieveLostData() : null;
  }

  Future retrieveLostData() async {
    final log = Logger();
    final LostDataResponse res = await picker.retrieveLostData();
    if (res.isEmpty) {
      return;
    }
    if (res.file != null) {
      setState(() {
        imagesList.add(File(res.file!.path));
      });
    } else {
      log.d(res.exception);
    }
  }

// //to open camera for videos
  // Future pickVideo() async {
  //   // final pv = await _picker.pickVideo(source: ImageSource.gallery);
  //   final pv = await picker.pickVideo(source: ImageSource.gallery);
  //   final pp = context.read<AddPostProvider>();
  //   if (pv != null) {
  //     pp.setPostVideo(pv);
  //   } else {
  //     showSnackBar(context, 'No video selected');
  //   }
  //   // }
  // }
}
