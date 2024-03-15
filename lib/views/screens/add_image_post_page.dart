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

// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/upload_video_page.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../../services/firebase_service.dart';
import '../../utils/custom_theme.dart';
import '../widgets/requestwidgets/form_input_builder.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<File> imagesList = [];
  List<String>? dwdImgList = [];
  double? value = 0;
  ImagePicker picker = ImagePicker();

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: .5,
        title: const Text("Add Post", style: TextStyle(color: Colors.black, fontSize: 15)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => addPost(),
            child: Text(
              'Post',
              style: subtitlestlye.copyWith(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
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
            controller: captionController,
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

  void addPost() async {
    UserModel? p = context.read<UserProvider>().usermodel;
    final pos = context.read<UserProvider>();
    if (captionController.text.isEmpty) {
      return showSnackBar(context, 'please add caption');
    }
    showProgressLoader();
    int i = 1;
    for (var img in imagesList) {
      setState(() {
        value = i / imagesList.length;
      });
      Reference ref = storage.ref().child('posts/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          dwdImgList!.add(value);
          i++;
        });
      });
    }

    if (dwdImgList!.isEmpty) {
      cancelProgressLoader();
      return showSnackBar(context, 'Please select image');
    }

    if (p.userName == null) {
      cancelProgressLoader();
      return showSnackBar(context, 'User Empty');
    }
    
    if (pos.latitude == null && pos.longitude == null) {
      await context.read<UserProvider>().getUserDataAsync(mAuth.currentUser!.uid);
      if (pos.latitude == null && pos.longitude == null) {
        cancelProgressLoader();
        return showSnackBar(context, 'Location Not Enabled');
      }
    }

    bool isPosted = await controller.addPost(
      post: PostsModel(
        videoUrl: "",
        imageUrl: dwdImgList,
        likes: [],
        caption: captionController.text.toString(),
        datePublished: DateTime.now().toString(),
        longitude: pos.longitude,
        latitude: pos.latitude,
      ),
    );
    if (isPosted) {
      cancelProgressLoader();
      showSnackBar(context, 'Post submitted');
      captionController.clear();
      dwdImgList!.clear();
      imagesList.clear();
      setState(() {
        imagesList.clear();
        dwdImgList!.clear();
      });
    } else {
      cancelProgressLoader();
      showSnackBar(context, 'Error something went wrong');
    }
  }
}
