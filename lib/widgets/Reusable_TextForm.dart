import 'package:flutter/material.dart';

TextField ReusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.black), // Set the text color to black
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black, // Set the icon color to black
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black), // Set the label text color to black
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor:  Color(0xFFF9F9F9),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
