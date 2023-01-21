import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/loader.dart';
import 'package:instagram_aa/views/widgets/profile_details.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({super.key, required this.id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserControllerImplement();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: user.getUserDataAsync(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: StatusProgressLoader()));
        }
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        }

        logger.d(snapshot.data!.userName);

        return Scaffold(
            appBar: AppBar(
              // iconTheme: IconThemeData(),
              title: const Text('Profile'),
              centerTitle: true,
              actions: [
                // IconButton(onPressed: () {

                // }, icon: const Icon(Icons.menu))
                PopupMenuButton(
                    itemBuilder: (context) =>[
                      PopupMenuItem(
                        child: Row(
                          children:const [Icon(Icons.help), Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('About App'),
                          )],
                        ),
                    ),
                    PopupMenuItem(
                        child: Row(
                          children:const [Icon(Icons.settings), Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('Settings'),
                          )],
                        ),
                    ),
                    PopupMenuItem(
                        child: Row(
                          children:const [Icon(Icons.logout), Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('Logout'),
                          )],
                        ),
                    ),
                    ],
                    child: const Icon(Icons.menu))
              ],
            ),
            body: RefreshIndicator(
                child: ProfileDetails(
                  user: snapshot.data!,
                ),
                onRefresh: () => user.getUserDataAsync(widget.id)));
      },
    );
  }
}
