// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/fadeanimate.dart';
import 'package:instagram_aa/provider/videoprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/screens/auth/signup_page.dart';
import 'package:instagram_aa/views/screens/home/mainhomepage.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/loader.dart';
import 'package:provider/provider.dart';

import '../../utils/pagesnavigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future afterSplash() async {
    if (mAuth.currentUser != null) {
      await context.read<VideoProvider>().loadVideos();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nextScreenClosePrev(context, FadeAnimate(const MainHomepage()));
      });
      
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nextScreenClosePrev(context, FadeAnimate(const SignupPage()));
      });
    }
  }

  @override
  void initState() {
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                    alignment: Alignment.center,
                    child: const AppName(
                        fontSize: 40, title: 'Green', span: 'Ghana'))),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                children: const[
                   SplashLoader(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
