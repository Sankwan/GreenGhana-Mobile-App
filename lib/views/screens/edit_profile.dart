import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/widgets/requestwidgets/form_input_builder.dart';
import 'package:instagram_aa/views/widgets/showOtpDialog.dart';

import '../../animation/slideanimate.dart';
import '../../utils/pagesnavigator.dart';
import '../../utils/progressloader.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String number;
  const EditProfile({super.key, required this.name, required this.number});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController editNameController = TextEditingController();
  TextEditingController editNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool _verifying = false;
  bool _verificationFailed = false;
  bool _phoneNumberUpdated = false;

  void _updateUserDetails(String newPhoneNumber, String newName, PhoneAuthCredential credential) async {
    final user = await mAuth.currentUser!;
    await user.updatePhoneNumber(credential);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({'user_phoneNumber': newPhoneNumber, 'user_name': newName});

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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        //how to make users profile image appear here by default and then change after edit is done
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
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
                    onPressed: () {},
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

                      try {
                        final PhoneVerificationCompleted verificationCompleted =
                            (PhoneAuthCredential phoneAuthCredential) {
                          mAuth.signInWithCredential(phoneAuthCredential);
                          _updateUserDetails(editNumberController.text,
                              editNumberController.text, phoneAuthCredential);
                        };

                        final PhoneVerificationFailed verificationFailed =
                            (FirebaseAuthException authException) {
                          setState(() {
                            _verifying = false;
                            _verificationFailed = true;
                          });
                          print(
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
                              await mAuth.signInWithCredential(credential);
                              _updateUserDetails(editNumberController.text,
                              editNumberController.text, credential);
                              cancelProgressLoader();
                              Navigator.of(context).pop();
                            },
                          );
                          print(
                              'Please check your phone for the verification code. Verification ID: $verificationId');
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
                      } catch (error) {}
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
              if (_verificationFailed)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Verification Failed',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              if (_phoneNumberUpdated)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phone Number Updated',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
