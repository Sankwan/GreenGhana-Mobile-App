import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/provider/user_posts.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/screens/edit_profile.dart';
import 'package:instagram_aa/views/widgets/cached_image.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';
import 'package:instagram_aa/views/widgets/postwidgets/single_post.dart';
import 'package:instagram_aa/views/widgets/postwidgets/tiktok_video_player.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  final UserModel user;
  const ProfileDetails({
    super.key,
    required this.user,
    required username,
  });

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  var post = UserControllerImplement();
  int likeCount = 0;
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var postCount = context.watch<UserPostsProvider>().postCount;
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomCircleAvatar(avatar: user.avatar!),
            SizedBox(
              height: 10,
            ),
            Text(
              user.userName!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      user.totalLikes.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Text(
                      'Likes',
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      user.totalPosts.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Text(
                      'Posts',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            user.userId == mAuth.currentUser!.uid
                ? ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      nextNav(
                          context,
                          EditProfile(
                            name: user.userName!,
                            number: user.userPhoneNumber.toString().trim(),
                            avatar: user.avatar!,
                          ));
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ))
                : Container(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        FutureBuilder<List<PostsModel>>(
          future: post.getUserProfileAsync(user.userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                // context
                //     .read<UserPostsProvider>()
                //     .getPostCount(snapshot.data!.length);
              });
              // setState(() {});
            }

            if (snapshot.data!.isEmpty) {
              return Column(
                children: [
                  Center(child: Text('No Posts')),
                ],
              );
            }
            logger.d(snapshot.data![0]);
            List<PostsModel> data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return data[index].imageUrl!.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            nextNav(context, SinglePost(post: data[index]));
                          },
                          child: CustomCacheImage(imageUrl: data[index].imageUrl![0], radius: 0),
                        )
                      : InkWell(
                          onTap: () {
                            nextNav(context, SinglePost(post: data[index]));
                          },
                          child: Stack(
                            children: 
                                  [TikTokVideoPlayer(
                                  play: false,
                                  data: data[index]),
                                  Positioned(
                                    bottom: 5,
                                    child: Icon(Icons.play_arrow_rounded, color: Colors.white,))
                                ],
                          ));
                },
              ),
            );
          },
        )
      ],
    );
  }
}
