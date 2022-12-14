import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_aa/models/usermodel.dart';

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
              backgroundImage: user.avatar!.isNotEmpty
                  ? AssetImage(user.avatar!)
                  : AssetImage(''),
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
            Text(user.userPhoneNumber!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Edit Profile')),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 13,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
