import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/auth/login_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Welcome to Green Ghana",
      bodyWidget: Text('Make a seedling request, select a location to pick-up the seedling. After receiving seedling, plant it in an appropriate place and monitor its growth', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/intro.png')),
    ),
    PageViewModel(
      title: "Location Settings",
      bodyWidget: Text(
          'As part of our onboarding process, we kindly request your consent to access your device background location as it is needed in order to view planted seedling locations; both yours and of other users.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/location.png')),
    ),
    PageViewModel(
      title: "Have Fun Planting",
      bodyWidget: Text('Take pictures and videos of your experience on the Green Ghana Day, post them and interact with other users on the app. \nLet\'s Get Started', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
      image: Center(child: Image.asset('assets/images/started.png')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: IntroductionScreen(
        pages: listPagesViewModel,
        showSkipButton: true,
        showNextButton: true,
        showDoneButton: true,
        skip: const Text("Skip"),
        done: const Text("Done"),
        next: const Icon(Icons.arrow_forward_ios_rounded),
        onDone: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('intro', false);
          nextNavRemoveHistory(context, LoginPage());
        },
      ),
    );
  }
}
