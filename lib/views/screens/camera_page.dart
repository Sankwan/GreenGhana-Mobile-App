import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/views/screens/video_preview.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});
    videoPick(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    // if (video != null) {
    //   snackBar(
    //     context,
    //     "Video Selected, ${video.path}",
    //   );
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => VideoPreview(
    //               videoFile: File(video.path), videoPath: video.path)));
    // } else {
    //   snackBar(
    //     context,
    //       "Error In Selecting Video , Please Choose A Video File");
    // }
  }

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Wrap( //will break to another line on overflow
                  direction: Axis.vertical, //use vertical to show  on vertical axis
                  children: <Widget>[
                        Container( 
                          margin:EdgeInsets.all(10),
                          child: FloatingActionButton(
                            onPressed: () => (ImageSource.camera),
                            child: Icon(Icons.video_camera_back),
                          )
                        ), //button first

                        Container( 
                          margin:EdgeInsets.all(10),
                          child: FloatingActionButton(
                            onPressed:  () => (ImageSource.camera),
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Icon(Icons.photo_size_select_actual_rounded),
                          )
                        ), // button second

                    

                ],
            ),
);
  }
}