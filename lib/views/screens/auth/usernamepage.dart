import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/utils/custombutton.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/home/mainhomepage.dart';

import '../../../services/firebase_service.dart';
import '../../widgets/edit_profile_pic.dart';

class UserNamePage extends StatefulWidget {
  final String phoneNumber;
  const UserNamePage({super.key, required this.phoneNumber});

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  late TextEditingController userNameController;
  final userControl = UserControllerImplement();
  ImagePicker picker = ImagePicker();
  String img = '';

  @override
  void initState() {
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        title: const Text('Personal Information'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  var res = await picker.pickImage(source: ImageSource.camera);
                  var imgUrl = File(res!.path);
                  Reference ref = storage
                      .ref()
                      .child('user/${mAuth.currentUser!.uid}/${imgUrl}');
                  await ref.putFile(imgUrl).whenComplete(() async {
                    await ref.getDownloadURL().then((value) {
                      setState(() {
                        img = value;
                      });
                    });
                  });
                },
                child: ProfilePic(imgUrl: img)),
            SizedBox(height: 80),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.black54)),
            ),
            const SizedBox(height: 16),
            CustomButton(onpress: () => saveUserData(), label: 'Save')
          ],
        ),
      ),
    );
  }

  Future saveUserData() async {
    if (userNameController.text.isEmpty) {
      showSnackBar(context, 'username is required');
      return;
    }
    showProgressLoader();
    await userControl
        .addUser(
            usermodel: UserModel(
                userPhoneNumber: widget.phoneNumber,
                userName: userNameController.text.trim(),
                avatar: img,
                totalPosts: 0,
                totalLikes: 0,
                totalRequests: 0))
        .then((value) {
      firebaseFireStore
          .collection('posts')
          .where('user_id', isEqualTo: mAuth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.map((e) {
          firebaseFireStore.collection('posts').doc(e.id).set({
            'user_name': userNameController.text.trim(),
            'user_avatar': img
          }, SetOptions(merge: true));
        });
      });
      cancelProgressLoader();
      nextscreenRemovePredicate(context, SlideAnimate(const MainHomepage()));
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
      cancelProgressLoader();
    });
  }
}
