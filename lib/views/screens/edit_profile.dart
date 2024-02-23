import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/auth/deleteaccount_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/edit_profile_pic.dart';
import 'package:instagram_aa/views/widgets/requestwidgets/form_input_builder.dart';
import 'package:instagram_aa/views/widgets/showOtpDialog.dart';

import '../../utils/progressloader.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String avatar;
  final String number;
  const EditProfile(
      {super.key,
      required this.name,
      required this.number,
      required this.avatar});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController editNameController = TextEditingController();
  TextEditingController editNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ImagePicker picker = ImagePicker();
  String img = '';

  bool _verifying = false;
  bool _verificationFailed = false;
  bool _phoneNumberUpdated = false;

  void _updateUserDetails(String newPhoneNumber, String newName,
      PhoneAuthCredential credential) async {
    final user = mAuth.currentUser!;
    await user
        .updatePhoneNumber(credential)
        .then((value) => FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({'user_phoneNumber': newPhoneNumber, 'user_name': newName}))
        .then((value) => showSnackBar(context, 'Details Updated'))
        .catchError((error) {
      List<String> errmsg = error.toString().split('] ');
      showSnackBar(context, errmsg[1]);
    });

    setState(() {
      _verifying = false;
      _phoneNumberUpdated = true;
    });
  }

  @override
  void initState() {
    editNameController.text = widget.name;
    editNumberController.text = widget.number.toString();
    super.initState();
  }

  @override
  void dispose() {
    editNameController.dispose();
    editNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String img = widget.avatar;
    String avatar = widget.avatar;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Edit your Profile'),
        centerTitle: true,
        elevation: .5,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 25, right: 30),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: InkWell(
                    onTap: () async {
                      var res =
                          await picker.pickImage(source: ImageSource.gallery);
                      var imgUrl = File(res!.path);
                      Reference ref = storage
                          .ref()
                          .child('user/${mAuth.currentUser!.uid}/${imgUrl}');
                      await ref.putFile(imgUrl).whenComplete(() async {
                        await ref.getDownloadURL().then((value) {
                          setState(() {
                            img = value;
                          });
                          logger.d(img);
                        });
                      });
                    },
                    child: img.isEmpty
                        ? ProfilePic(imgUrl: widget.avatar)
                        : ProfilePic(imgUrl: img)),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Name',
                style: subtitlestlye.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //current user name
              FormInputBuilder(
                hintText: '',
                controller: editNameController,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Number',
                style: subtitlestlye.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //current user number
              FormInputBuilder(
                hintText: '',
                controller: editNumberController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text("CANCEL",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _verifying = true;
                      });

                      if (widget.number == editNumberController.text) {
                        return firebaseFireStore
                            .collection('users')
                            .doc(mAuth.currentUser!.uid)
                            .update({
                          'user_name': editNameController.text,
                          'avatar': img.isEmpty ? widget.avatar : img
                        }).then((value) {
                          setState(() {
                            _verifying = false;
                            showSnackBar(context, 'Details Upated');
                          });
                        });
                      }

                      try {
                        final PhoneVerificationCompleted verificationCompleted =
                            (PhoneAuthCredential phoneAuthCredential) {
                          // mAuth.signInWithCredential(phoneAuthCredential);
                          _updateUserDetails(editNumberController.text,
                              editNameController.text, phoneAuthCredential);
                        };

                        final PhoneVerificationFailed verificationFailed =
                            (FirebaseAuthException authException) {
                          setState(() {
                            _verifying = false;
                            _verificationFailed = true;
                          });
                          showSnackBar(context,
                              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
                        };

                        codeSent(String verificationId,
                            int? forceResendingToken) async {
                          setState(() {
                            _verifying = false;
                          });
                          showOTPDialog(
                            codeController: codeController,
                            context: context,
                            onPressed: () async {
                              showProgressLoader();
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: codeController.text.trim(),
                              );
                              // !!! Works only on Android, iOS !!!
                              // await mAuth.signInWithCredential(credential);
                              _updateUserDetails(editNumberController.text,
                                  editNameController.text, credential);
                              cancelProgressLoader();
                              Navigator.of(context).pop();
                            },
                          );
                        }

                        final PhoneCodeAutoRetrievalTimeout
                            codeAutoRetrievalTimeout = (String verificationId) {
                          setState(() {
                            _verifying = false;
                          });
                          print('Auto retrieval time out');
                        };

                        await mAuth.verifyPhoneNumber(
                            phoneNumber: editNumberController.text,
                            timeout: const Duration(seconds: 120),
                            verificationCompleted: verificationCompleted,
                            verificationFailed: verificationFailed,
                            codeSent: codeSent,
                            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
                      } catch (error) {
                        snackBar(context, error.toString());
                      }
                    },
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                      ),
                    ),
                  )
                ],
              ),
              if (_verifying)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                TextButton(onPressed: (){                 
                  // FirebaseServices().deleteAccount();
                  showDialog(context: context, builder: (context) => AccountDeletionButton(number: widget.number,));
                                      
                }, child: Text('Delete Account', style: TextStyle(color: Colors.grey),))
            ],
          ),
        ),
      ),
    );
  }
}
