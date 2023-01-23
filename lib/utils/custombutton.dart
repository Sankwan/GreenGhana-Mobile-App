
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onpress;
  final String label;
  const CustomButton({Key? key, required this.onpress, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ),
    );
  }
}
