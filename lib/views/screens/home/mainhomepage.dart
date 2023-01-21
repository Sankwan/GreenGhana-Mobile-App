import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_aa/provider/homepageprovider.dart';
import 'package:instagram_aa/utils/tablist.dart';
import 'package:provider/provider.dart';

class MainHomepage extends StatefulWidget {
  const MainHomepage({super.key});

  @override
  State<MainHomepage> createState() => _MainHomepageState();
}

class _MainHomepageState extends State<MainHomepage> {
  @override
  Widget build(BuildContext context) {
    final hp = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black54,
          onTap: hp.onTabChange,
          currentIndex: hp.tabIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.seedling), label: 'Applied'),
            // BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Saved'),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.mapPin), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartSimple), label: 'Saved'),
          ]),
      body: IndexedStack(
        index: hp.tabIndex,
        children: fragmentList,
      ),
      // body: Text("Main Home Page"),
    );
  }
}
