import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/provider/post_provider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/widgets/postwidgets/comment_screen.dart';
import 'package:instagram_aa/views/widgets/postwidgets/like_animation.dart';
import 'package:instagram_aa/views/widgets/postwidgets/tiktok_video_player.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/posts_model.dart';
import '../cached_image.dart';

class PostImageContainer extends StatefulWidget {
  final PostsModel post;
  final List likes;
  final List comments;
  final Function() updateLike;
  final Function() updateComment;
  const PostImageContainer({
    super.key,
    required this.post,
    required this.likes,
    required this.comments,
    required this.updateLike,
    required this.updateComment,
  });

  @override
  State<PostImageContainer> createState() => _PostImageContainerState();
}

class _PostImageContainerState extends State<PostImageContainer> {
  Future<PostsModel> streamLikes() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var snapshot = firestore.collection('posts').doc(widget.post.postId).get();
    return snapshot.then((value) => PostsModel.fromJson(value.data()!));
  }

  bool isLikeAnimating = false;
  PostControllerImplement pController = PostControllerImplement();

  @override
  Widget build(BuildContext context) {
    PostProvider p = context.watch<PostProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
          width: double.infinity,
          height: 430,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black12,
          ),
          child: GestureDetector(
            onDoubleTap: () {
              pController.likePost(postId: widget.post.postId);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                widget.post.videoUrl == ""
                    ? CarouselSlider.builder(
                        itemCount: widget.post.imageUrl?.length,
                        options: CarouselOptions(
                          padEnds: false,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          height: MediaQuery.of(context).size.height,
                          autoPlay: false,
                          // disableCenter: true,
                          onPageChanged: (index, re) {
                            p.onIndexChange(index);
                          },
                        ),
                        itemBuilder: (context, index, reas) {
                          final img = widget.post.imageUrl?[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: CustomCacheImage(
                              imageUrl: img,
                              radius: 5,
                            ),
                          );
                        },
                      )
                    : TikTokVideoPlayer(play: true, data: widget.post),
                //double tap animation for likes (complete)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    width: double.infinity,
                    height: 55,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 0,
                          children: [
                            IconButton(
                              onPressed: () {
                                // FirebaseServices().likedVideo(post.userId!);
                                widget.updateLike();
                                pController.likePost(
                                    postId: widget.post.postId);
                              },
                              icon: Icon(
                                widget.post.likes
                                            ?.contains(auth.currentUser!.uid) ??
                                        false
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 28,
                                color: widget.post.likes
                                            ?.contains(auth.currentUser!.uid) ??
                                        false
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                try {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Comments(
                                            id: widget.post.postId!,
                                            updateComment: mounted
                                                ? widget.updateComment
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } catch (error) {
                                  logs.d(error);
                                }
                              },
                              icon: Icon(
                                CupertinoIcons.text_bubble,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            //  const Icon(
                            //     Icons.comment_outlined,
                            //     size: 28,
                            //     color: Colors.white,
                            //   ),
                          ],
                        ),
                        widget.post.imageUrl!.isNotEmpty ||
                                widget.post.videoUrl == ""
                            ? AnimatedSmoothIndicator(
                                activeIndex: p.dotIndex,
                                count: widget.post.imageUrl!.length,
                                effect: const WormEffect(
                                  dotColor: Colors.white70,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: Colors.green,
                                ),
                              )
                            : Container(),
                        Container(
                          width: 80,
                        ),
                        // IconButton(
                        //   onPressed: () {

                        //   },
                        //   icon: Icon(widget.post.likes!
                        //                 .contains(auth.currentUser!.uid)
                        //             ? Icons.bookmark
                        //             : Icons.bookmark_border_outlined,
                        //         size: 28,
                        //         color: widget.post.likes!
                        //                 .contains(auth.currentUser!.uid)
                        //             ? Colors.white
                        //             : Colors.black,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// Widget carouselIndicator() {
//   return DotsIndicator(
//     dotsCount: pageLength,
//     position: currentIndexPage,
//     decorator: DotsDecorator(
//       size: const Size.square(9.0),
//       activeSize: const Size(18.0, 9.0),
//       activeShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//     ),
//   );
// }
