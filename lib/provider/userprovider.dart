import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';

class UserProvider with ChangeNotifier{
  final userControl = UserControllerImplement();
  UserModel? _usermodel;
  
  UserModel? get usermodel => _usermodel;

  // Future getUserDataAsync() async{
  //   UserModel um = await userControl.getUserDataAsync();
  //   _usermodel = um;
  //   notifyListeners();
  // }
}