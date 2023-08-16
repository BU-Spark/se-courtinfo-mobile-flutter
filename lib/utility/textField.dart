import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff1f2c5c)), // Customize the color if needed
        ),
      ),
    );
  }
}
