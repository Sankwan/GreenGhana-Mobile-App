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
import 'package:instagram_aa/views/screens/profile/profile_page.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_item_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/refresh_data.dart';
import '../../widgets/loader.dart';
import '../../widgets/searchwidget.dart';

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
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  List<PostsModel> _posts = [];
  final int _nextPageTrigger = 3;
  Future saveToken = FirebaseServices().getToken();
  bool _isLoading = false;
  DocumentSnapshot?
      lastPost; // Variable to store the date of the last fetched post

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _isLastPage = false;
    _loading = true;
    _error = false;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await saveToken;
      await context
          .read<UserProvider>()
          .getUserDataAsync(mAuth.currentUser!.uid);

      // super.initState();
      context.read<PostProvider>().getPosts(limit: 5);
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      await updatePostCount(mAuth.currentUser!.uid);
      await updateLikeCount(mAuth.currentUser!.uid);
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
          _posts.clear();
          await p.getPosts(limit: 5);
          setState(() {});
        },
        child: FutureBuilder<List<PostsModel>>(
            future: p.postData,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Scaffold(body: Center(child: StatusProgressLoader()));
              }
              List<PostsModel> posts = snapshot.data!;
              _posts.addAll(posts);
              _posts = _posts.toSet().toList();
              // SchedulerBinding.instance.addPostFrameCallback((_) async {
              //   snackBar(context, "Mapped");
              //   setState(() {
              //     _isLastPage = posts.length < _numberOfPostsPerRequest;
              //     _loading = false;
              //     _pageNumber = _pageNumber + 1;
              //   });
              // });

              return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification is ScrollEndNotification &&
                        scrollNotification.metrics.extentAfter == 0) {
                      if (_posts.isNotEmpty) {
                        getLastPost() async {
                          var postCol = firebaseFireStore.collection("posts");
                          var data =
                              await postCol.doc(_posts.last.postId).get();
                          lastPost = data;
                          p.loadMorePosts(limit: 5, document: lastPost);
                          setState(() {});
                        }
                        getLastPost();
                      }
                    }
                    return true;
                  },
                  // onNotification: (scrollNotification){
                  //   if (scrollNotification is ScrollEndNotification && scrollNotification.metrics.extentAfter == 0) {
                  //       var refreshedPosts = await RefreshData().onRefresh(documentSnapshot: posts.last);
                  //       _posts.addAll(refreshedPosts);
                  //       snackBar(context, "Reached Bottom");
                  //     return _isLastPage;
                  //   }
                  //     return _isLastPage;
                  // },
                  child: _posts.length > 0
                      ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                                controller: widget.controller,
                                cacheExtent: 800.0 * _posts.length,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _posts.length,
                                separatorBuilder: (context, i) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (context, i) {
                                  final pp = _posts[i];
                                  return PostItemCard(
                                    post: pp,
                                    onPress: () {},
                                  );
                                },
                              ),
                            StatusProgressLoader()
                          ],
                        ),
                      )
                      : Container());
            }),
      ),
      // child: ),
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
