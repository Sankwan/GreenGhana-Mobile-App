import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/widgets/postwidgets/custom_circle_avatar.dart';

import '../screens/profile/profile_page.dart';
import 'custom_widgets.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search users...",
          ),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: ScrollController(),
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    // logger.wtf(data);
                    UserModel user = UserModel.fromJson(snapshots.data!.docs[index]);
                    if (user.userId == null) {
                      logger.d(user.userName);
                      return Container();
                    }

                    String username = user.userName!;
                    String userId = user.userId!;
                    String userAvatar = user.avatar!;
                    if (name.isEmpty) {
                      return ListTile(
                        onTap: () {
                          nextNav(context, ProfilePage(id: userId));
                        },
                        title: Text("$username "),
                        leading: CustomCircleAvatar(avatar: userAvatar),
                      );
                    }
                    if (data['user_name']
                            .toString()
                            .startsWith(name.toLowerCase()) ||
                        data['user_name']
                            .toString()
                            .startsWith(name.toUpperCase())) {
                      String username = data["user_name"];
                      String userId = data["user_id"];
                      String userAvatar = data["avatar"];
                      return ListTile(
                        onTap: () {
                          nextNav(context, ProfilePage(id: userId));
                        },
                        title: Text("$username "),
                        leading: CustomCircleAvatar(avatar: userAvatar),
                      );
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
