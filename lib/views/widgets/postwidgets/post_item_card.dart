import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/screens/profile/profile_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_image_containe.dart';
import 'package:jiffy/jiffy.dart';

import '../../../services/firebase_service.dart';
import '../../screens/home_display/homepage.dart';

class PostItemCard extends StatefulWidget {
  final PostsModel post;
  final Function() onPress;
  const PostItemCard({super.key, required this.post, required this.onPress});

  @override
  State<PostItemCard> createState() => _PostItemCardState();
}

class _PostItemCardState extends State<PostItemCard> {
  UserControllerImplement user = UserControllerImplement();
  bool _isLoading = false;
  List likes = [];
  List comments = [];

//   updatePostCount(id) async {
//   final getPost = await firebaseFireStore
//       .collection('posts')
//       .where('user_id', isEqualTo: id)
//       .get();
//   return firebaseFireStore
//       .collection('users')
//       .doc(id)
//       .update({'total_posts': getPost.docs.length});
// }

// updateLikeCount(id) async {
//   int likeCount = 0;
//   await firebaseFireStore
//       .collection('posts')
//       .where('user_id', isEqualTo: id)
//       .get()
//       .then((value) {
//     var list = value.docs.map((e) {
//       var count = PostsModel.fromJson(e.data());
//       likeCount += count.likes!.length;
//     });
//     logger.d(list);
//     logger.d(likeCount);
//   });
//   return firebaseFireStore
//       .collection('users')
//       .doc(id)
//       .update({'total_likes': likeCount});
// }

//prevents multiple pages of to open when we tap this multiple times
  void _onTap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration.zero, () async {
        await updateLikeCount(widget.post.userId);
        await updatePostCount(widget.post.userId);
      });

      await nextNav(context, ProfilePage(id: widget.post.userId!));

      setState(() {
        _isLoading = false;
      });
    }
  }

  _updateLike() {
    if (widget.post.likes == null) return;
    if (widget.post.likes!.contains(mAuth.currentUser!.uid)) {
      likes.remove(mAuth.currentUser!.uid);
    } else {
      likes.add(mAuth.currentUser!.uid);
    }
    setState(() {});
  }

  _updateComment() {
    if (widget.post.comments == null) return;
    if (widget.post.comments!.contains(mAuth.currentUser!.uid)) {
      comments.remove(mAuth.currentUser!.uid);
    } else {
      comments.add(mAuth.currentUser!.uid);
    }
    setState(() {});
  }

  Future<PostsModel> streamLikes() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var snapshot = firestore.collection('posts').doc(widget.post.postId).get();
    return snapshot.then((value) => PostsModel.fromJson(value.data()!));
  }

  bool expand = false;

  @override
  void initState() {
    // TODO: implement initState
    likes = widget.post.likes ?? [];
    comments = widget.post.comments ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeago = Jiffy(widget.post.datePublished).fromNow();
    return FutureBuilder<UserModel>(
        future: user.getUserDataAsync(widget.post.userId!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
            //use shimmer in place of container
          }
          return InkWell(
            onTap: widget.onPress,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: _onTap,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    leading: CustomCircleAvatar(avatar: snapshot.data!.avatar!),
                    title: Text(
                      snapshot.data!.userName!,
                      style: subtitlestlye.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    subtitle: Text(
                      timeago,
                      style: subtitlestlye.copyWith(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  PostImageContainer(
                    post: widget.post,
                    likes: likes,
                    comments: comments,
                    updateLike: _updateLike,
                    updateComment: _updateComment,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 12, bottom: 5),
                        child: Text(
                          '${likes.length} likes',
                          style: subtitlestlye.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 12, bottom: 5),
                        child: Text(
                          '${widget.post.comments?.length != null ? widget.post.comments?.length : 0} comments',
                          style: subtitlestlye.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  //text to label the caption
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                    ),
                    child: Text(
                      'Caption',
                      style: subtitlestlye.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 3,
                      top: 3,
                      bottom: 20,
                    ),
                    child: Text(
                      '${widget.post.caption}',
                      maxLines: expand == true ? 10 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: subtitlestlye.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Visibility(
                    visible: widget.post.caption!.length > 105,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            expand = !expand;
                          });
                        },
                        child: Text(
                          expand ? 'Show less' : 'Show more',
                          style: subtitlestlye.copyWith(
                              fontSize: 13,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
