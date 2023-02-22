import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/screens/profile_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_image_containe.dart';
import 'package:jiffy/jiffy.dart';

class PostItemCard extends StatefulWidget {
  final PostsModel post;
  final Function() onPress;
  const PostItemCard({super.key, required this.post, required this.onPress});

  @override
  State<PostItemCard> createState() => _PostItemCardState();
}

class _PostItemCardState extends State<PostItemCard> {
  @override
  bool expand = false;
  Widget build(BuildContext context) {
    final timeago = Jiffy(widget.post.datePublished).fromNow();
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              leading: InkWell(
                  onTap: () {
                    nextNav(context, ProfilePage(id: widget.post.userId!));
                  },
                  child:
                      CustomCircleAvatar(avatar: widget.post.userAvatar!)),
              title: Text(
                widget.post.userName!,
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
              // trailing: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.more_vert,
              //     size: 22,
              //     color: Colors.grey.shade500,
              //   ),
              // ),
            ),
            PostImageContainer(
              post: widget.post,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 12, bottom: 5),
                  child: Text(
                    '${widget.post.likes?.length} likes',
                    style: subtitlestlye.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 12, bottom: 5),
                  child: Text(
                    '${widget.post.comments?.length != null ? widget.post.comments?.length : 0} comments',
                    style: subtitlestlye.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
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
  }
}
