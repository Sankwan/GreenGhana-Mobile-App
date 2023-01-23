import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/controllers/post_controller.dart';
import 'package:instagram_aa/models/posts_model.dart';

class PostProvider with ChangeNotifier{
  final postController = PostControllerImplement();

  List<PostsModel> _postData = [];

  UnmodifiableListView<PostsModel> get postData => UnmodifiableListView(_postData);


  Future getPosts() async{
    final p = await postController.loadPosts();
    _postData = p;
    notifyListeners();
  }
  
}