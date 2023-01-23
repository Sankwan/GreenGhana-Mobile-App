// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/views/screens/auth/usernamepage.dart';

import '../utils/showsnackbar.dart';
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
        showSnackBar(context, e.message!);
        cancelProgressLoader();
      },
      // Displays a dialog box when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        cancelProgressLoader();
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            showProgressLoader();
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
