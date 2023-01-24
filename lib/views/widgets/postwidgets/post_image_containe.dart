import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_aa/provider/post_provider.dart';
import 'package:instagram_aa/views/widgets/postwidgets/tiktok_video_player.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/posts_model.dart';
import '../cached_image.dart';

class PostImageContainer extends StatelessWidget {
  final PostsModel post;

  const PostImageContainer({super.key, required this.post});

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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              post.videoUrl == ""
                  ? CarouselSlider.builder(
                      itemCount: post.imageUrl?.length,
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
                        final img = post.imageUrl?[index];
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
                  : TikTokVideoPlayer(videoUrl: post.videoUrl!),
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
                        spacing: 16,
                        children: const [
                          Icon(
                            Icons.favorite_border_outlined,
                            size: 28,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.comment_outlined,
                            size: 28,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      post.imageUrl!.isNotEmpty || post.videoUrl == ""
                          ? AnimatedSmoothIndicator(
                              activeIndex: p.dotIndex,
                              count: post.imageUrl!.length,
                              effect: const WormEffect(
                                dotColor: Colors.white70,
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.green,
                              ),
                            )
                          : Container(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_outline,
                          size: 28,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
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
