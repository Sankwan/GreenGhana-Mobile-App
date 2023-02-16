import 'package:flutter/material.dart';

class UserPostsProvider with ChangeNotifier {
  int _postCount = 0;
  int _likeCount = 0;

  get postCount => _postCount;
  get likeCount => _likeCount;

  getPostCount(int count) {
    _postCount = count;
    notifyListeners();
  }

  getLikeCount(int count) {
    _likeCount = count;
    notifyListeners();
  }
}
