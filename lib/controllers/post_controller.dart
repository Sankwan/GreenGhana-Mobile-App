import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/services/firebase_service.dart';

abstract class PostController {
  Future<bool> addPost({PostsModel? post});
  Future<String?> getDownloadUrl(File file, String bucket);
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
  
}
