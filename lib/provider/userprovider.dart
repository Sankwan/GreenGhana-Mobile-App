import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/utils/app_utils.dart';

class UserProvider with ChangeNotifier {
  final userControl = UserControllerImplement();
  UserModel? _usermodel;
  double? _latitiude;
  double? _longitude;

  UserModel? get usermodel => _usermodel;
  double? get latitude => _latitiude;
  double? get longitude => _longitude;

  Future getUserDataAsync(String id) async {
    Position position = await AppUtils().determinePosition();
    UserModel um = await userControl.getUserDataAsync(id);
    _usermodel = um;
    _latitiude = position.latitude;
    _longitude = position.longitude;
    notifyListeners();
  }
}
