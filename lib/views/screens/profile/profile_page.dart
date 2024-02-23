import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/screens/about_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/loader.dart';
import 'package:instagram_aa/views/widgets/profile/profile_details.dart';

import '../../widgets/custom_widgets/popup_menu.dart';

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
    // Get user from the database
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
        // return scaffold is user is not null
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              elevation: .5,
              actions: [
                CustomPopUpMenu(
                  popupMenuItem: [
                    CustomPopUpItem(
                        icon: Icons.help, text: 'About App', value: 1),
                    CustomPopUpItem(
                        icon: Icons.logout, text: 'Logout', value: 2),
                  ],
                  onSelected: (menu) {
                    if (menu == 1) {
                      nextNav(context, AboutPage());
                    } else if (menu == 2) {
                      FirebaseServices().logout(context);
                    }
                  },
                )
              ],
            ),
            // User Details container
            body: ProfileDetails(
              user: snapshot.data!,
              username: null,
            ));
      },
    );
  }
}
