import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/models/comment.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

import '../views/screens/auth/login_page.dart';

var auth = FirebaseAuth.instance;
var firebaseFireStore = FirebaseFirestore.instance;

class FirebaseServices {
  File? proimg;

  String _postID = "";

  List<String> thumbnails = [];

  Reference ref = FirebaseStorage.instance
      .ref()
      .child('profilePics')
      .child(FirebaseAuth.instance.currentUser!.uid);

  Map<String, dynamic> user = Map<String, dynamic>();

  // Upadate Post
  updatePostID(String id) {
    _postID = id;
    // fetchComment();
  }

  // Create User
  createUser(number, id) {
    firebaseFireStore
        .collection('users')
        .doc(id)
        .set({'username': '', 'id': id, 'phoneNumber': number});
  }

  // Update Name
  updateName(name) {
    firebaseFireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'username': name});
  }

//takes user to loginPage
//login and logout edited. take note
  logout(BuildContext context) {
    auth
        .signOut()
        .whenComplete(() => nextNavRemoveHistory(context, LoginPage()));
  }

  // _uploadProPic(File image) async {
  //   UploadTask uploadTask = ref.putFile(image);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String imageDwnUrl = await snapshot.ref.getDownloadURL();
  //   return imageDwnUrl;
  // }

  // Get All Videos
  getVideos() {
    return firebaseFireStore.collection('videos').snapshots();
  }

  // Like Videos
  likedVideo(String id) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection("posts").doc(id).get();
    var uid = auth.currentUser!.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection("posts").doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection("posts").doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  //Share Videos
  shareVideo(String vidId) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection("videos").doc(vidId).get();

    int newShareCount = (doc.data() as dynamic)["shareCount"] + 1;
    await FirebaseFirestore.instance
        .collection("videos")
        .doc(vidId)
        .update({"shareCount": newShareCount});
  }

  // Uplaod Profile Image
  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  // Select Profile Image
  void pickImage() async {
    print("IMAGE PICKED SUCCESSFULLY");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if(image == null) return;

    final img = File(image!.path);
    proimg = img;
  }

  // Get Comment
  getComment() {
    return firebaseFireStore
        .collection("videos")
        .doc(_postID)
        .collection("comments")
        .snapshots();
  }

  // Like Comment
  likeComment(String id) async {
    var uid = auth.currentUser!.uid;
    DocumentSnapshot doc = await firebaseFireStore
        .collection('videos')
        .doc(_postID)
        .collection("comments")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFireStore
          .collection('videos')
          .doc(_postID)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebaseFireStore
          .collection('videos')
          .doc(_postID)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  // Post Comment
  postComment(BuildContext context, String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseFireStore
            .collection("users")
            .doc(auth.currentUser!.uid.toString())
            .get();
        var allDocs = await firebaseFireStore
            .collection("videos")
            .doc(_postID)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
            username: (userDoc.data() as dynamic)['name'],
            comment: commentText.trim(),
            datePub: DateTime.now(),
            likes: [],
            profilePic: (userDoc.data() as dynamic)['profilePic'],
            uid: FirebaseAuth.instance.currentUser!.uid,
            id: 'Comment $len');

        await FirebaseFirestore.instance
            .collection("videos")
            .doc(_postID)
            .collection("comments")
            .doc('Comment $len')
            .set(comment.toJson());

        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postID)
            .get();
        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postID)
            .update({
          'commentsCount': (doc.data() as dynamic)['commentsCount'] + 1,
        });
      } else {
        snackBar(context,
            "Please Enter some content \n Please write something in comment");
      }
    } catch (e) {
      snackBar(context, "Error in sending comment, ${e.toString()}");
    }
  }

  // Search User
  searchUser(String query) {
    return firebaseFireStore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots();
  }

  // Get User Info
  getUserData(String id) {
    return firebaseFireStore
        .collection("posts")
        .where("user_id", isEqualTo: id)
        .get();
  }

  // Get Followers
  getUserFollowers(String id) {
    return firebaseFireStore
        .collection('users')
        .doc(id)
        .collection('followers')
        .snapshots();
  }

  // Get Followers
  getUserVideos() {}

  // Follow User
  followuser(String id) async {
    var doc = await firebaseFireStore
        .collection("users")
        .doc(id)
        .collection("followers")
        .doc(auth.currentUser!.uid)
        .get();

    if (!doc.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("followers")
          .doc(auth.currentUser!.uid)
          .set({});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("following")
          .doc(id)
          .set({});

      // _user.value
      //     .update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("followers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("following")
          .doc(id)
          .delete();

      // _user.value
      //     .update('followers', (value) => (int.parse(value) - 1).toString());
    }

    // _user.value.update('isFollowing', (value) => !value);
    // update();
  }

  userData(String id) {
    return firebaseFireStore.collection('user').doc(id).snapshots();
  }

  follower(String id) {
    return firebaseFireStore
        .collection('users')
        .doc(id)
        .collection('followers')
        .snapshots();
  }

  followering(String id) {
    return firebaseFireStore
        .collection('users')
        .doc(id)
        .collection('following')
        .snapshots();
  }

  followUser(String id) async {
    var doc = await firebaseFireStore.collection("users").doc(id).get();
    if (!doc.exists && !doc['followers'].contains(auth.currentUser!.uid)) {
      await FirebaseFirestore.instance.collection("users").doc(id).set({
        'followers': [...doc['followers'], auth.currentUser!.uid]
      });
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(auth.currentUser!.uid)
      //     .collection("following")
      //     .doc(id)
      //     .set({});
    } else {
      await FirebaseFirestore.instance.collection("users").doc(id);
      // .delete();
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .collection("following")
      //     .doc(id)
      //     .delete();
    }
  }
}
