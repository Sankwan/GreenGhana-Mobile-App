import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_aa/views/screens/graph.dart';
import 'package:instagram_aa/views/screens/homepage.dart';
import 'package:instagram_aa/views/screens/map_page.dart';
import 'package:instagram_aa/views/screens/request_seedling.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BottomNavigationTabs extends StatefulWidget {
  const BottomNavigationTabs({super.key});

  @override
  State<BottomNavigationTabs> createState() => _BottomNavigationTabsState();
}

class _BottomNavigationTabsState extends State<BottomNavigationTabs> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const RequestSeedling(),
    const MapPage(),
    const Graph(),
  ];

  Future pickImage() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Graph(
              // videoFile: File(video.path),
              // videoPath: video.path,
              ),
        ),
      );
    }
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 0,
        // shape: CircularNotchedRectangle(),
        // notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color:
                              currentTab == 0 ? Colors.green : Colors.black54,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.green
                                  : Colors.black54,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const RequestSeedling();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.seedling,
                          color:
                              currentTab == 1 ? Colors.green : Colors.black54,
                        ),
                        Text(
                          'Requests',
                          style: TextStyle(
                            color:
                                currentTab == 1 ? Colors.green : Colors.black54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //to open the camera
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  // pickImage();
                  showDialog(
                      context: context,
                      builder: ((context) => SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                onPressed: () =>
                                    pickImage(),
                                child: Row(
                                  children: const [
                                    Icon(Icons.image),
                                    Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Text(
                                        'Take a Picture',
                                        // style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  pickVideo(ImageSource.camera, context);
                                },
                                // => pickVideo(ImageSource.camera, context),

                                child: Row(
                                  children: const [
                                    Icon(Icons.video_camera_back),
                                    Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Text(
                                        'Take a Video',
                                        // style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )));
                  setState(() {
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                      color: currentTab == 2 ? Colors.green : Colors.black54,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen = const MapPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.mapPin,
                          color:
                              currentTab == 3 ? Colors.green : Colors.black54,
                        ),
                        Text(
                          'Map',
                          style: TextStyle(
                            color:
                                currentTab == 3 ? Colors.green : Colors.black54,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Graph();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.chartSimple,
                          color:
                              currentTab == 4 ? Colors.green : Colors.black54,
                        ),
                        Text(
                          'Graph',
                          style: TextStyle(
                            color:
                                currentTab == 4 ? Colors.green : Colors.black54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_aa/views/screens/graph.dart';
// import 'package:instagram_aa/views/screens/homepage.dart';
// import 'package:instagram_aa/views/screens/map_page.dart';
// import 'package:instagram_aa/views/screens/request_seedling.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'colors.dart';

// class BottomNavigationTabs extends StatefulWidget {
//   const BottomNavigationTabs({super.key});

//   @override
//   State<BottomNavigationTabs> createState() => _BottomNavigationTabsState();
// }

// class _BottomNavigationTabsState extends State<BottomNavigationTabs> {
//   PageController _pageController = PageController();
//   int _currentIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(  
//       body: PageView(
//         controller: _pageController,
//         children: <Widget>[
//           HomePage(),
//           RequestSeedling(),
//           MapPage(),
//           Graph(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavyBar(
//         containerHeight: 55.0,
//         backgroundColor: Colors.grey.shade50,
//         selectedIndex: _currentIndex,
//         showElevation: true,
//         itemCornerRadius: 24,
//         curve: Curves.easeIn,
//         onItemSelected: (index) => setState(() {
//           _currentIndex = index;
//           _pageController.animateToPage(index,
//               duration: const Duration(milliseconds: 100),
//               curve: Curves.easeIn);
//         }),
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(
//             inactiveColor: Colors.grey,
//             icon: const Icon(Icons.dashboard_rounded, color: Colors.black54,),
//             title: const Text(''),
//             activeColor: iconColor,
//             textAlign: TextAlign.left,
//           ),
//           BottomNavyBarItem(
//             inactiveColor: Colors.grey,
//             icon: const Icon(FontAwesomeIcons.seedling, color: Colors.black54,),
//             title: const Text('Requests'),
//             activeColor: iconColor,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             inactiveColor: Colors.grey,
//             icon: const Icon(FontAwesomeIcons.mapPin, color: Colors.black54,),
//             title: const Text(
//               'Map ',
//             ),
//             activeColor: iconColor,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             inactiveColor: Colors.grey,
//             icon: const Icon(FontAwesomeIcons.chartSimple, color: Colors.black54,),
//             title: const Text('Graph'),
//             activeColor:iconColor,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }

