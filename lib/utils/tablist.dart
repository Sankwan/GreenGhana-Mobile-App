import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/camera_page.dart';
import 'package:instagram_aa/views/screens/graph.dart';
import 'package:instagram_aa/views/screens/homepage.dart';
import 'package:instagram_aa/views/screens/map_page.dart';
import 'package:instagram_aa/views/screens/request_seedling.dart';

const List<Widget> fragmentList = [
  HomePage(),
  RequestSeedling(),
  //for the camera page
  CameraPage(),
  MapPage(),
  Graph(),
];
