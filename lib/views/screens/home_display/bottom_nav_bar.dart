import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../add_image_post_page.dart';
import './graph.dart';
import './homepage.dart';
import './map_page.dart';
import './request_seedling.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final ScrollController _scrollController = ScrollController();

  int selectedIndex = 0;

  bool displayHome = true;
  bool displayRequest = false;
  bool displayPost = false;
  bool displayMap = false;
  bool displayGraph = false;

  @override
  Widget build(BuildContext context) {
    // final hp = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: _buildNavigationBar(),
      // BottomNavigationBar(
      //   showUnselectedLabels: true,
      //   selectedFontSize: 14,
      //   unselectedFontSize: 14,
      //   elevation: 0,
      //   type: BottomNavigationBarType.shifting,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   unselectedItemColor: Colors.black54,
      //   onTap: (index) {
      //     if (hp.tabIndex == index && index == 0) {
      //       _scrollController.animateTo(0,
      //           duration: Duration(milliseconds: 1500),
      //           curve: Curves.easeInOut);
      //     }
      //     hp.onTabChange(index);
      //   },
      //   currentIndex: hp.tabIndex,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(FontAwesomeIcons.seedling), label: 'Request'),
      //     BottomNavigationBarItem(
      //         icon: Icon(FontAwesomeIcons.circlePlus), label: ''),
      //     BottomNavigationBarItem(
      //         icon: Icon(FontAwesomeIcons.mapPin), label: 'Map'),
      //     BottomNavigationBarItem(
      //         icon: Icon(FontAwesomeIcons.chartSimple), label: 'Graph'),
      //   ],
      // ),
      body: IndexedStack(
        index: selectedIndex,
        children: _buildBody(),
      ),
      // body: _buildBody()[selectedIndex],

      // IndexedStack(
      //   index: hp.tabIndex,
      //   children: <Widget>[
      //     HomePage(
      //       key: PageStorageKey("Home"),
      //       controller: _scrollController,
      //     ),
      //     RequestSeedling(
      //       key: PageStorageKey("Request"),
      //     ),
      //     PostPage(
      //       key: PageStorageKey("Post"),
      //     ),
      //     MapPage(
      //       key: PageStorageKey("Map"),
      //     ),
      //     Graph(
      //       key: PageStorageKey("Graph"),
      //     ),
      //   ],
      // ),
    );
  }

  // Build Navigation Bar
  _buildNavigationBar() {
    return NavigationBar(
      destinations: destinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      backgroundColor: Theme.of(context).colorScheme.background,
      height: 60,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      animationDuration: Duration(milliseconds: 500),
      indicatorColor: Theme.of(context).primaryColor,
    );
  }

  // Build Destinations
  List<NavigationDestination> get destinations => <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.seedling),
          label: 'Request',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.circlePlus),
          label: 'Post',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.mapPin),
          label: 'Map',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.chartSimple),
          label: 'Graph',
        ),
      ];

  // Build Body
  List<Widget> _buildBody() {
    List<Widget> homeScreens = [
      HomePage(
        controller: _scrollController,
      ),
      VisibilityDetector(
        key: Key('request_seedling'),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            setState(() {
              displayRequest = false;
            });
          } else {
            setState(() {
              displayRequest = true;
            });
          }
        },
        child: displayRequest ? RequestSeedling() : Container(),
      ),
      VisibilityDetector(
        key: Key('post_page'),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            setState(() {
              displayPost = false;
            });
          } else {
            setState(() {
              displayPost = true;
            });
          }
        },
        child: displayPost ? PostPage() : Container(),
      ),
      VisibilityDetector(
        key: Key('map_page'),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            setState(() {
              displayMap = false;
            });
          } else {
            setState(() {
              displayMap = true;
            });
          }
        },
        child: displayMap ? MapPage() : Container(),
      ),
      VisibilityDetector(
        key: Key('graph'),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            setState(() {
              displayGraph = false;
            });
          } else {
            setState(() {
              displayGraph = true;
            });
          }
        },
        child: displayGraph ? Graph() : Container(),
      ),
    ];
    return homeScreens;
  }
}
