import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';

class PostProvider with ChangeNotifier {
  final postController = PostControllerImplement();

  Stream<List<PostsModel>> _postData = Stream.fromIterable([]);
  Stream<List<PostsModel>> get postData => _postData;

  int _dotIndex = 0;
  int get dotIndex => _dotIndex;

  Stream getPosts() {
    final p = postController.loadPosts();
    _postData = p;
    notifyListeners();
    return _postData;
  }

  void onIndexChange(int newIndex) {
    _dotIndex = newIndex;
    notifyListeners();
  }
}
