import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  void onTabChange(int newIndex) {
    _tabIndex = newIndex;
    notifyListeners();
  }
}
