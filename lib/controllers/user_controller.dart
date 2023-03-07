import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

abstract class UserController {
  Future<bool> addUser({UserModel usermodel});
  Future<UserModel> getUserDataAsync(String id);
  Future<List<PostsModel>> getUserProfileAsync(String id);
}

class UserControllerImplement implements UserController {
  @override
  Future<bool> addUser({UserModel? usermodel}) async {
    usermodel!.userId = mAuth.currentUser!.uid;
    await usercol
        .doc(mAuth.currentUser!.uid)
        .set(usermodel.toJson(), SetOptions(merge: true));
    return true;
  }

  @override
  Future<UserModel> getUserDataAsync(String id) async {
    DocumentSnapshot snapshot = await usercol.doc(id).get();
    return UserModel.fromJson(snapshot);
  }

  @override
  Future<List<PostsModel>> getUserProfileAsync(String id) async {
    // List<PostsModel> postList = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await postcol.where('user_id', isEqualTo: id).get();
    return snapshot.docs.map((e) => PostsModel.fromJson(e.data())).toList();
  }
}
