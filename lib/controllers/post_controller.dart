import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

abstract class PostController {
  Future<bool> addPost({PostsModel? post});
  Future<String?> getDownloadUrl(File file, String bucket);
  Future<List<PostsModel>> loadPosts();
  Future<List<PostsModel>> loadMorePosts({required int limit, required DocumentSnapshot<Map<String, dynamic>> document});
  Future likePost({String? postId});
}

class PostControllerImplement implements PostController {
  @override
  Future<bool> addPost({PostsModel? post}) async {
    final pc = postcol.doc();
    post!.postId = pc.id;
    post.userId = mAuth.currentUser?.uid;
    await pc.set(post.toJson());
    return true;
  }

  @override
  Future<String?> getDownloadUrl(File file, String bucket) async {
    try {
      String fileName = file.path.split('/').last;
      final Reference ref = storage.ref().child(bucket).child(fileName);
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot snapshot = await Future.value(uploadTask);
      final String downloadUri = await snapshot.ref.getDownloadURL();
      return downloadUri;
    } catch (e) {
      logs.d(e);
      return null;
    }
  }

  @override
  Future<List<PostsModel>> loadPosts({int? limit}) async{
    if (limit == null) {
      final postsData = await postcol
          .orderBy('date_published', descending: true)
          .get();
      final posts = postsData.docs.map((e) => PostsModel.fromJson(e.data())).toList();
      return posts;
    } else {
      final postsData = await postcol
          .limit(limit)
          .orderBy('date_published', descending: true)
          .get();
      final posts = postsData.docs.map((e) => PostsModel.fromJson(e.data())).toList();
      return posts;
    }
  }

  @override
  Future<List<PostsModel>> loadMorePosts({required int limit, required DocumentSnapshot<Map<String, dynamic>> document}) async{
      final postsData = await postcol
          .limit(limit)
          .orderBy('date_published', descending: true)
          .startAfterDocument(document)
          .get();
      final documents = postsData.docs;
      final posts = postsData.docs.map((e) => PostsModel.fromJson(e.data())).toList();
      return posts;
  }

  @override
  Future likePost({String? postId}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is signed in");
    }
    final ref = FirebaseFirestore.instance.collection("posts").doc(postId);
    final post = await ref.get();
    if (!post.exists) {
      throw Exception("Post not found");
    }
    final liked = post.data()!["likes"] as List<dynamic>;
    if (liked.contains(user.uid)) {
      liked.remove(user.uid);
      await ref.update({"likes": liked}).then((value) => logger.d('Unliked'));
    } else {
      liked.add(user.uid);
      await ref.update({"likes": liked});
    }
  }
}
