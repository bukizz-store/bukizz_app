import 'package:bukizz_frontend/constants/font_family.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isPasswordType;
  final TextEditingController controller;

  ReusableTextField(this.text, this.icon, this.isPasswordType, this.controller);

  @override
  _ReusableTextFieldState createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPasswordType && !isPasswordVisible,
      enableSuggestions: !widget.isPasswordType,
      autocorrect: !widget.isPasswordType,
      cursorColor: Color(0xFF121212),
      style: TextStyle(
        color: Color(0xFF121212),
        fontFamily: FontFamily.roboto.name
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: Color(0xFFB8B8B8),
        ),
        labelText: widget.text,
        labelStyle: TextStyle(
          color: Color(0xFFB8B8B8),
          fontFamily: FontFamily.roboto.name,
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Color(0xFFF9F9F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        suffixIcon: widget.isPasswordType
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Color(0xFFB8B8B8),
          ),
          onPressed: () {
            // Toggle password visibility
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        )
            : null,
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
