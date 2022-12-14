import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/views/widgets/loader.dart';
import 'package:instagram_aa/views/widgets/profile_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserControllerImplement();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: user.getUserDataAsync(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: StatusProgressLoader()));
        }
        if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        }

        return Scaffold(
            appBar: AppBar(
              // iconTheme: IconThemeData(),
              title: const Text('Profile'),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
              ],
            ),
            body: RefreshIndicator(
                child: ProfileDetails(user: snapshot.data!,), onRefresh: () => user.getUserDataAsync()));
      },
    );
  }
}
