import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';

class PostProvider with ChangeNotifier {
  final postController = PostControllerImplement();

  Future<List<PostsModel>> _postData = Future.value([]);
  Future<List<PostsModel>> get postData => _postData;

  int _dotIndex = 0;
  int get dotIndex => _dotIndex;

  Future getPosts({int? limit}) {
    final p = postController.loadPosts(limit: limit);
    _postData = p;
    notifyListeners();
    return _postData;
  }

  Future loadMorePosts({required int limit, required document}) async{
    var postCol = await firebaseFireStore.collection("posts");
    final p = postController.loadMorePosts(limit: limit, document: document);
    _postData = p;
    notifyListeners();
    return _postData;
  }

  void onIndexChange(int newIndex) {
    _dotIndex = newIndex;
    notifyListeners();
  }
}
