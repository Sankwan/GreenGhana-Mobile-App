import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/controllers/request_controller.dart';
import 'package:instagram_aa/models/request_model.dart';

import '../models/posts_model.dart';

class RequestProvider with ChangeNotifier {

  final RequestControllerImplement controller = RequestControllerImplement();


  String _selectedSeed = 'seed...';
  String _selectedLocation = "location...";

  String get selectedSeed => _selectedSeed;
  String get selectedLocation => _selectedLocation;

  void onSeedSelect(s) {
    _selectedSeed = s;
    notifyListeners();
  }

  void onLocationSelect(s){
    _selectedLocation = s;
    notifyListeners();
  }

}
