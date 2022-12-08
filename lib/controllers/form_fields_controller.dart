import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:instagram_aa/views/widgets/colors.dart';


var textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Color(0xFF8e8e8e)));


//Phone Number TextField
Widget numberFormField(
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,
    maxLength: 10,
    style: const TextStyle(letterSpacing: 10),
    // textAlign: TextAlign.center,
    decoration: InputDecoration(
        hintText: '(024)xxxxxxx',
        filled: true,
        counterText: '',
        fillColor: Colors.white,
        border: textFieldBorder),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Phone number is required!';
      } else if (value.length < 10) {
        return 'Phone Number should exactly 10 digits';
      } else if (!value.startsWith('02') && !value.startsWith('05')) {
        return 'Invalid Number Format';
      }
      return null;
    },
  );
}

// OTP Fields
opt(BuildContext context, hasError, pin, onChange(value)) {
  return PinCodeTextField(
    appContext: context,
    controller: pin,
    keyboardType: TextInputType.number,
    length: 6,
    enableActiveFill: true,
    pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60,
        fieldWidth: 50,
        activeFillColor: hasError ? Colors.orange : Colors.white,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 2),
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white),
    onChanged: (value) {
      onChange(value);
    },
  );
}

Widget textFormField(
    TextEditingController controller,) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    // style: const TextStyle(letterSpacing: 10),
    decoration: InputDecoration(
        hintText: 'Name',
        filled: true,
        fillColor: Colors.white,
        border: textFieldBorder),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Name is required!';
      } else if (value.length < 10) {
        return 'Name should not contain less than 10 characters';
      }
      return null;
    },
  );
}



class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:const BorderSide(
              color: borderColor,
            )),
      ),
      obscureText: isObscure,
    );
  }
}
