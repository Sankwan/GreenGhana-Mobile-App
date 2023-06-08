import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_aa/provider/homepageprovider.dart';
import 'package:instagram_aa/views/screens/homepage.dart';
import 'package:instagram_aa/views/screens/request_seedling.dart';
import 'package:provider/provider.dart';

import '../add_image_post_page.dart';
import '../graph.dart';
import '../map_page.dart';

class MainHomepage extends StatefulWidget {
  const MainHomepage({super.key});

  @override
  State<MainHomepage> createState() => _MainHomepageState();
}

class _MainHomepageState extends State<MainHomepage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final hp = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black54,
          onTap: (index) {
            if (hp.tabIndex == index && index == 0) {
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeInOut);
            }
            hp.onTabChange(index);
          },
          currentIndex: hp.tabIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.seedling), label: 'Request'),
            // BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.circlePlus), label: ''),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.mapPin), label: 'Map'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartSimple), label: 'Graph'),
          ]),
      body: IndexedStack(index: hp.tabIndex, children: <Widget>[
        HomePage(
          controller: _scrollController,
        ),
        RequestSeedling(),
        PostPage(),
        MapPage(),
        Graph(),
      ]),
      // body: Text("Main Home Page"),
    );
  }
}
