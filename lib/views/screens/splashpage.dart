// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/fadeanimate.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/screens/auth/login_page.dart';
import 'package:instagram_aa/views/screens/auth/onboarding_screen.dart';
import 'package:instagram_aa/views/screens/home/mainhomepage.dart';
import 'package:instagram_aa/views/widgets/app_name.dart';
import 'package:instagram_aa/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/pagesnavigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  Future afterSplash() async {
    mAuth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('intro')) {
      await prefs.setBool('intro', true);
    }
    final bool? intro = await prefs.getBool('intro');
    if (mAuth.currentUser != null) {
      await context
          .read<UserProvider>()
          .getUserDataAsync(mAuth.currentUser!.uid);

      Future.delayed(const Duration(seconds: 1)).then((value) {
        nextScreenClosePrev(context, FadeAnimate(const MainHomepage()));
      });
    } else {
      // await context
      //     .read<UserProvider>()
      //     .getUserDataAsync(mAuth.currentUser!.uid);
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        nextScreenClosePrev(context,
            FadeAnimate(intro! ? const OnBoardingScreen() : const LoginPage()));
      });
    }
  }

  @override
  void initState() {
    afterSplash();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Container(
                alignment: Alignment.center,
                child:
                    const AppName(fontSize: 40, title: 'Green', span: 'Ghana')),
            SizedBox(height: 50),
            Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/greenghanalogo.png'),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                children: const [
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
