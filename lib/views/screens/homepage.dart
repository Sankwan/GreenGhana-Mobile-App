// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/provider/post_provider.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/utils/app_utils.dart';
import 'package:instagram_aa/views/screens/profile_page.dart';
import 'package:instagram_aa/views/screens/search_screen.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostControllerImplement controller = PostControllerImplement();

  @override
  Widget build(BuildContext context) {
    PostProvider p = context.watch<PostProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const AppName(fontSize: 18, title: 'Green', span: 'Ghana'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              nextNav(context, SearchScreen());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black54,
              size: 27,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                nextNav(
                  context,
                  ProfilePage(
                    id: auth.currentUser!.uid,
                  ),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child:
                    Image(image: AssetImage('assets/images/profilepic1.jpg')),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () async {
          await context.read<UserProvider>().getUserDataAsync();
          await p.getPosts();
        },
        child: FutureBuilder<List<PostsModel>>(
          future: controller.loadPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppUtils().feedPreload(context);
            }
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No Data",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
              );
            }
            return AppUtils().feedPreload(context);
            // return ListView.separated(
            //   physics: const BouncingScrollPhysics(),
            //   itemCount: snapshot.data!.length,
            //   separatorBuilder: (context, i) {
            //     return const SizedBox(
            //       height: 10,
            //     );
            //   },
            //   itemBuilder: (context, i) {
            //     return Text(i.toString());
            //   },
            // );
          },
        ),
      ),
    );
  }
}
