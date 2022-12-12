// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_aa/animation/fadeanimate.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/auth/usernamepage.dart';

abstract class AuthController{
  Future<void> phoneSignIn({required String phoneNumber, required BuildContext context});
}

class AuthControlImplement implements AuthController{
  @override
  Future<void> phoneSignIn({String? phoneNumber, BuildContext? context}) async{
      TextEditingController codeController = TextEditingController();
    await mAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
         verificationCompleted: (PhoneAuthCredential credential) async {
          // !!! works only on android !!!
          await mAuth.signInWithCredential(credential);
        },
       verificationFailed: (e) {
          showSnackBar(context!, e.message!);
          logs.d(e.message);
        },
         codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
            controller: codeController,
            context: context!,
            verifyButton: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              // !!! Works only on Android, iOS !!!
              await mAuth.signInWithCredential(credential).then((value) {
                nextScreenClosePrev(context, FadeAnimate(UserNamePage(phoneNumber: phoneNumber!)));
                // closeUI(context);
              });
              //  closeUI(context);
                // nextScreen(context, FadeAnimate(UserNamePage(phoneNumber: phoneNumber!)));
                // logs.d('user signed in');

            },
          );
        }),
      codeAutoRetrievalTimeout: (vid){});
  }

}
