import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/views/screens/auth/profile_setter.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

class Otp_Page extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const Otp_Page({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<Otp_Page> createState() => _Otp_PageState();
}

class _Otp_PageState extends State<Otp_Page> {
  var firebaseServices = FirebaseServices();
  // var pin = '';
  TextEditingController pin = TextEditingController();
  bool load = false;
  bool hasError = false;
  late String pinCode;
  onChange(value) {
    setState(() {
      pinCode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
      ),
      body: ListView(children: [
        const Text(
          'Enter PIN code \nsent to your number',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
        ),
        opt(context, hasError, pin, onChange),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                // style: buttonStyle1,
                onPressed: () async {
                  //   setState(() {
                  //     load = true;
                  //   });
                  //   if (pinCode.isNotEmpty) {
                  //     logger.d(pinCode);
                  //     PhoneAuthCredential credential =
                  //         PhoneAuthProvider.credential(
                  //       verificationId: widget.verificationId,
                  //       smsCode: pinCode,
                  //     );
                  //     try {
                  //       await auth
                  //           .signInWithCredential(credential)
                  //           .then((userCredential) {
                  //         if (userCredential.user != null) {
                  //           logger.d(userCredential.user!.uid);
                  //           firebaseServices.createUser(
                  //               widget.phoneNumber, userCredential.user!.uid);
                  //           nextNavRemoveHistory(context, const ProfileSetter());
                  //         }
                  //       });
                  //     } catch (error) {
                  //       pin.clear();
                  //       setState(() {
                  //         load = false;
                  //       });
                  //       logger.d(error);
                  //     }
                  //   }
                  //
                },
                child: Row(
                  children: [
                    const Text(
                      'Verify PIN',
                    ),
                    Visibility(
                      visible: load,
                      child: const SizedBox(
                        width: 18,
                      ),
                    ),
                    Visibility(
                      visible: load,
                      child: const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          )),
                    )
                  ],
                )),
          ],
        ),
      ]),
    );
  }
}
