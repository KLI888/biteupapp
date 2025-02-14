import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? prefixText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.prefixText = "",
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 12.0),
        constraints: BoxConstraints(maxHeight: height * 0.065, maxWidth: width),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        // Use prefixIcon instead of prefixText for fixed prefix behavior
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 5),
          child: Text(
            prefixText ?? '',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
    );
  }
}
