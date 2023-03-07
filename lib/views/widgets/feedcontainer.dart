import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/models/video.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/views/widgets/cached_image.dart';
import 'package:instagram_aa/views/widgets/cached_image_with_dark.dart';
import 'package:instagram_aa/views/widgets/video_icon.dart';

class FeedContainer extends StatelessWidget {
  final Video vids;
  final Function() onimagePress;
  const FeedContainer(
      {super.key, required this.vids, required this.onimagePress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: double.infinity,
      // height: 560.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //USERNAME AND AVATAR CODE SECTION+++++++++++++++++++++++++++++++++++++++++++++
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 2),
                              blurRadius: 6.0)
                        ]),
                    child: CircleAvatar(
                      child: ClipOval(
                          child: CustomCacheImage(
                              imageUrl: "${vids.profilePic}", radius: 0)),
                    ),
                  ),
                  title: Text('${vids.username}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('5min'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.black,
                  ),
                ),
                //Main IMAGE OR VIDEO CODE SECTION+++++++++++++++++++++++++++++++++++++++++++++
                InkWell(
                  onTap: onimagePress,
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 8.0)
                        ],
                      ),
                      child: vids.videoUrl == ""
                          ? CustomCacheImage(
                              imageUrl: vids.thumbnail, radius: 25.0)
                          : CustomCacheImageWithDarkFilterFull(
                              imageUrl: vids.thumbnail!,
                              radius: 25.0,
                              allPosition: true),
                    ),
                    VideoIcon(videourl: "${vids.videoUrl}", iconSize: 60)
                  ]),
                ),
                //LIKE COMMENT AND BOOKMARK CODE SECTION++++++++++++++++++++++++++++++++++++++++++++++++++++
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  size: 30.0,
                                )),
                            Text(
                              '${vids.likes!.length}',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const SizedBox(width: 20.0),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  //i commented this out because i commented the comments page i created

                                  //         nextScreen(
                                  // context, SlideAnimate(const CommentsScreen()));
                                },
                                icon: const Icon(Icons.chat, size: 30.0)),
                            Text(
                              '${vids.commentsCount}',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black54,
                      ),
                      iconSize: 30.0,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
