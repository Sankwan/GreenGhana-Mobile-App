// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/provider/post_provider.dart';
import 'package:instagram_aa/views/screens/profile_page.dart';
import 'package:instagram_aa/views/screens/search_screen.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/postwidgets/post_item_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostControllerImplement controller = PostControllerImplement();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{ 
      await context.read<PostProvider>().getPosts();
    });
  }

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
            await p.getPosts();
          },
          child:
              ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: p.postData.length,
            separatorBuilder: (context, i) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, i) {
              final pp = p.postData[i];
              return PostItemCard(
                post: pp,
              );
            },
          )),
    );
  }
}
