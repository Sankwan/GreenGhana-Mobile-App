// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/views/screens/auth/usernamepage.dart';
import 'package:instagram_aa/views/screens/home_display/bottom_nav_bar.dart';

import '../utils/showsnackbar.dart';
import '../views/screens/auth/login_page.dart';
import '../views/screens/auth/signup_page.dart';
import '../views/widgets/showOtpDialog.dart';

class FirebaseAuthMethod {
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    //   // FOR ANDROID, IOS
    showProgressLoader();
    await mAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await mAuth.signInWithCredential(credential);
      },
      // Displays a message when verification fails
      verificationFailed: (e) {
        cancelProgressLoader();
        showSnackBar(context, e.message!);
      },
      // Displays a dialog box when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        cancelProgressLoader();
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            showProgressLoader();
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              // !!! Works only on Android, iOS !!!
              await mAuth.signInWithCredential(credential);
              cancelProgressLoader();
              // Navigator.of(context).pop(); // Remove the dialog box
              nextScreenClosePrev(
                context,
                SlideAnimate(
                  UserNamePage(phoneNumber: phoneNumber),
                ),
              );
            } catch (e) {
              cancelProgressLoader();
              showSnackBar(context, e.toString());
            }
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        cancelProgressLoader();
      },
    );
  }
}

//new auth for login page
//skips the username page
//need to handle errors for wrong username. Same for wrong OTP
class FirebaseAuthLoginMethod {
  Future<void> phoneLogIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    //   // FOR ANDROID, IOS
    showProgressLoader();
    await mAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await mAuth.signInWithCredential(credential);
      },
      // Displays a message when verification fails
      verificationFailed: (e) {
        cancelProgressLoader();
        showSnackBar(context, e.message!);
      },
      // Displays a dialog box when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        cancelProgressLoader();
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            showProgressLoader();
            if (mAuth.currentUser != null) {
              nextscreenRemovePredicate(
                context,
                SlideAnimate(
                  BottomNavBar(),
                ),
              );
            }
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              // !!! Works only on Android, iOS !!!
              await mAuth.signInWithCredential(credential);
              cancelProgressLoader();
              // Navigator.of(context).pop(); // Remove the dialog box
              nextscreenRemovePredicate(
                context,
                SlideAnimate(
                  BottomNavBar(),
                ),
              );
            } catch (e) {
              cancelProgressLoader();
              showSnackBar(context, e.toString());
            }
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        cancelProgressLoader();
      },
    );
  }
}

//
//auth for deleting account
//
class FirebaseAuthDeleteMethod {
  Future<void> phoneDelete(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    //   // FOR ANDROID, IOS
    showProgressLoader();
    await mAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await mAuth.signInWithCredential(credential);
      },
      // Displays a message when verification fails
      verificationFailed: (e) {
        cancelProgressLoader();
        showSnackBar(context, e.message!);
      },
      // Displays a dialog box when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        cancelProgressLoader();
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            showProgressLoader();
            if (Platform.isAndroid) {
              if (mAuth.currentUser != null) {
                await FirebaseServices().deleteAccount();
                await FirebaseServices().logout(context);
                // nextscreenRemovePredicate(
                //   context,
                //   SlideAnimate(
                //     SignupPage(),
                //   ),
                // );
                return;
              }
            }
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              // !!! Works only on Android, iOS !!!
              await mAuth.signInWithCredential(credential);
              await FirebaseServices().deleteAccount();
              await FirebaseServices().logout(context);
              cancelProgressLoader();
            } catch (e) {
              cancelProgressLoader();
              showSnackBar(context, e.toString());
            }
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        cancelProgressLoader();
      },
    );
  }
}