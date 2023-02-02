import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/screens/edit_profile.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

class ProfileDetails extends StatefulWidget {
  final UserModel user;
  const ProfileDetails({
    super.key,
    required this.user,
  });

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  user.avatar!.isNotEmpty ? AssetImage(user.avatar!) : null,
              child: user.avatar!.isEmpty
                  ? Icon(
                      CupertinoIcons.person_crop_circle,
                      size: 120,
                    )
                  : Container(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              user.userName!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Likes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(user.totalLikes!.toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Requests',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(user.totalRequests!.toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Posts',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(user.totalPosts!.toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              nextNav(context, const EditProfile());
            }, child: const Text('Edit Profile')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 13,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.red : Colors.green,
                  height: 50,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
