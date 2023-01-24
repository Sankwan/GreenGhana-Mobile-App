import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_image_containe.dart';
import 'package:jiffy/jiffy.dart';

class PostItemCard extends StatelessWidget {
  final PostsModel post;
  const PostItemCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final timeago = Jiffy(post.datePublished).fromNow();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: CustomCircleAvatar(avatar: "$post.userAvatar"),
            title: Text(
              post.userName!,
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
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 22,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          PostImageContainer(
            post: post,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 12, bottom: 5),
            child: Text(
              '${post.likes?.length} likes',
              style: subtitlestlye.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 3,
              top: 3,
              bottom: 8,
            ),
            child: Text(
              '${post.caption}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: subtitlestlye.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 2, bottom: 10),
            child: Text(
              'Show this post',
              style: subtitlestlye.copyWith(
                  fontSize: 13,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
