import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_aa/views/screens/auth/signup_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/app_utils.dart';

class AccountDeletionButton extends StatelessWidget {
  final String number;
  AccountDeletionButton({ super.key, required this.number });


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actionsAlignment: MainAxisAlignment.center,
      title: Icon(
        Icons.warning_rounded,
        size: 60,
        color: Colors.orangeAccent,
      ),
      content: Text(
          'Are you sure? This will delete all your data from the app. \nYou wont\'t get access to the app unless you register again'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
              String normalNumber =
                  AppUtils.normalizePhoneNumber(number);
              FirebaseAuthDeleteMethod()
                  .phoneDelete(context, "+233$normalNumber");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: const Text("Delete"),
          ),
        ),
      ],
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Step 1: Delete User Data
      await deleteUserData(user.uid);

      // Step 2: Delete User Authentication
      await user.delete();

      // Step 3: Delete User Account
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.delete();

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Account Deleted'),
            content: Text('Your account has been successfully deleted.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Route to the register page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Helper function to delete user data
  Future<void> deleteUserData(String userId) async {
    // Delete posts
    final postsRef = FirebaseFirestore.instance.collection('posts');
    final userPostsQuery = postsRef.where('userId', isEqualTo: userId);

    await userPostsQuery.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete pictures
    final picturesRef = FirebaseFirestore.instance.collection('pictures');
    final userPicturesQuery = picturesRef.where('userId', isEqualTo: userId);

    await userPicturesQuery.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete videos
    final videosRef = FirebaseFirestore.instance.collection('videos');
    final userVideosQuery = videosRef.where('userId', isEqualTo: userId);

    await userVideosQuery.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete any other associated data here
  }
}
