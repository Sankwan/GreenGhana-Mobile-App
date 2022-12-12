import 'package:flutter/material.dart';
import 'package:instagram_aa/utils/custombutton.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}


void showOTPDialog({
  required VoidCallback verifyButton,
  required BuildContext context,
  required TextEditingController controller
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Enter OTP Code',
            style: TextStyle(
              
            ),
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter otp code here',
              hintStyle: TextStyle(
                color:  Colors.black54,
                fontSize: 16
              )
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CustomButton(
                onpress: verifyButton,
                label: 'Verify OTP',
              ),
            ),
          ],
        );
      });
}