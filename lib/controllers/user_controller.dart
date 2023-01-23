import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/services/firebase_service.dart';

abstract class UserController{
  Future<bool> addUser({UserModel usermodel}); 
  Future<UserModel> getUserDataAsync();
}

class UserControllerImplement implements UserController{
  @override
  Future<bool> addUser({UserModel? usermodel}) async{
     usermodel!.userId = mAuth.currentUser!.uid;
    await usercol.doc(mAuth.currentUser!.uid).set(usermodel.toJson());
    return true;
  }
  
  @override
  Future<UserModel> getUserDataAsync() async{
    DocumentSnapshot snapshot = await usercol.doc(mAuth.currentUser!.uid).get();
    return UserModel.fromJson(snapshot);
  }

}

