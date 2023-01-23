import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/animation/video_controller.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/models/video.dart';
import 'package:instagram_aa/provider/videoprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/views/screens/feed_details_page.dart';
import 'package:instagram_aa/views/screens/profile_page.dart';
import 'package:instagram_aa/views/screens/search_screen.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/feedcontainer.dart';
import 'package:instagram_aa/views/widgets/widgetextensions.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final videocontrol = VideoControllerImplement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        // title: const Text(
        //   'Green Ghana',
        //   style: TextStyle(color: Colors.black54, fontSize: 15),
        // ),
        title: const AppName(fontSize: 15, title: 'Green', span: 'Ghana'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              //nextnav is from joshua
              //nextScreen is from Jona
              //use one, clear one or?
              nextNav(context, SearchScreen());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black54,
              size: 27,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                // Sends Current User Id to Page to Access Current Users Account
                nextNav(context, ProfilePage(id: auth.currentUser!.uid,));
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child:
                    Image(image: AssetImage('assets/images/profilepic1.jpg')),
              ),
            ),
          ),
        ],
      ),
      // body: FutureBuilder<List<Video>>(
      //     future: videocontrol.getAllVideos(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(child: pagePreload(context));
      //       }
      //       if (snapshot.hasError) {
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: Colors.pink,
      //           ),
      //         );
      //       }
      //       return RefreshIndicator(
      //         onRefresh: () => videocontrol.getAllVideos(),
      //         color: Theme.of(context).primaryColor,
      //         child: ListView.separated(
      //           physics: const BouncingScrollPhysics(),
      //           itemCount: snapshot.data!.length,
      //           separatorBuilder: (context, index) =>
      //               const SizedBox(height: 10),
      //           itemBuilder: (context, index) {
      //             final vs = snapshot.data!.toList()[index];
      //             return FeedContainer(
      //                 vids: vs,
      //                 onimagePress: () => nextScreen(
      //                     context, SlideAnimate(FeedDetailsPage(vid: vs))));
      //           },
      //         ),
      //       );
      //     }),
    );
  }
}
