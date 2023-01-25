import 'package:flutter/cupertino.dart';

class RequestProvider with ChangeNotifier {
  String _selectedSeed = 'seed...';
  String _selectedLocation = "location...";

  String get selectedSeed => _selectedSeed;
  String get selectedLocation => _selectedLocation;

  void onSeedSelect(s) {
    _selectedSeed = s;
    notifyListeners();
  }

  void onLocationSelect(s) {
    _selectedLocation = s;
    notifyListeners();
  }

  void clearFields(){
    _selectedSeed = 'seed...';
    _selectedLocation = 'location';
    notifyListeners();
  }
}
