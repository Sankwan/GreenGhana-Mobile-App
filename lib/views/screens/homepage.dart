// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/provider/post_provider.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/screens/planting_info.dart';
import 'package:instagram_aa/views/screens/profile_page.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_item_card.dart';
import 'package:provider/provider.dart';

import '../widgets/loader.dart';
import '../widgets/searchwidget.dart';

updatePostCount(id) async {
  final getPost = await firebaseFireStore
      .collection('posts')
      .where('user_id', isEqualTo: id)
      .get();
  return firebaseFireStore
      .collection('users')
      .doc(id)
      .update({'total_posts': getPost.docs.length});
}

updateLikeCount(id) async {
  int likeCount = 0;
  await firebaseFireStore
      .collection('posts')
      .where('user_id', isEqualTo: id)
      .get()
      .then((value) {
    var list = value.docs.map((e) {
      var count = PostsModel.fromJson(e.data());
      likeCount += count.likes!.length;
    });
    logger.d(list);
    logger.d(likeCount);
  });
  return firebaseFireStore
      .collection('users')
      .doc(id)
      .update({'total_likes': likeCount});
}

class HomePage extends StatefulWidget {
  final ScrollController controller;
  const HomePage({Key? key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostControllerImplement controller = PostControllerImplement();
  UserControllerImplement user = UserControllerImplement();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool _isLoading = false;

  getToken() async {
    String? token = await messaging.getToken();
    firebaseFireStore
        .collection('users')
        .doc(mAuth.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      getToken();
      await context
          .read<UserProvider>()
          .getUserDataAsync(mAuth.currentUser!.uid);
      await context.read<PostProvider>().getPosts();
    });
  }

  void _onTap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration.zero, () async {
        await updatePostCount(mAuth.currentUser!.uid);
        await updateLikeCount(mAuth.currentUser!.uid);
      });

      await nextNav(context, ProfilePage(id: auth.currentUser!.uid));

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PostProvider p = context.watch<PostProvider>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10,
            child: Image(image: AssetImage('assets/images/greenghanalogo.png')),
          ),
        ),
        leadingWidth: 40,
        centerTitle: false,
        title: const AppName(fontSize: 18, title: 'Green', span: 'Ghana'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              nextNav(context, SearchPageWidget());
              // showSearch(
              //   context: context,
              //   delegate: SearchWidget(),
              // );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black54,
              size: 27,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InkWell(
              onTap: _onTap,
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
      body: RefreshIndicator(
          color: Colors.green,
          onRefresh: () async {
            await p.getPosts();
          },
          child: StreamBuilder<List<PostsModel>>(
              stream: p.postData,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Scaffold(body: Center(child: StatusProgressLoader()));
                }
                List<PostsModel> posts = snapshot.data!;
                return ListView.separated(
                  controller: widget.controller,
                  cacheExtent: 800.0 * posts.length,
                  physics: const BouncingScrollPhysics(),
                  itemCount: posts.length,
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, i) {
                    final pp = posts[i];
                    return PostItemCard(
                      post: pp,
                      onPress: () {},
                    );
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          FontAwesomeIcons.trowel,
        ),
        onPressed: () {
          nextNav(context, PlantingInfo());
        },
      ),
    );
  }
}
