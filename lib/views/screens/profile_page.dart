import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/screens/about_page.dart';
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
              color: Colors.black,
            ),
          );
        }

        logger.d(snapshot.data!.userName);

        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              // iconTheme: IconThemeData(),
              title: const Text('Profile'),
              centerTitle: true,
              elevation: .5,
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: const [
                                Icon(Icons.help),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text('About App'),
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text('Logout'),
                                )
                              ],
                            ),
                          ),
                        ],
                    onSelected: (int menu) {
                      if (menu == 1) {
                        nextNav(context, const AboutPage());
                      } else if (menu == 2) {
                        FirebaseServices().logout(context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.more_vert),
                    ))
              ],
            ),
            body: RefreshIndicator(
                child: ProfileDetails(
                  user: snapshot.data!,
                  username: null,
                ),
                onRefresh: () => user.getUserDataAsync(widget.id)));
      },
    );
  }
}
