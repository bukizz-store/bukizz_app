
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../../utils/dimensions.dart';



class CustomLoginForm extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String labelText;
  final bool isPasswordType;
  final IconData ?trailingIcon;
  final InputType type;

  CustomLoginForm({
    required this.width,
    required this.height,
    required this.controller,
    required this.hintText,
    this.icon, required this.labelText, required this.isPasswordType,
    this.trailingIcon,
    required this.type
  });

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  bool isPasswordVisible = false; // Declare isPasswordVisible here

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    TextInputType keyboardType;
    List<TextInputFormatter>? inputFormatters;

    if (widget.type == InputType.pinCode) {
      keyboardType = TextInputType.number;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)];
    } else if (widget.type == InputType.phone) {
      keyboardType = TextInputType.phone;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)];
    } else {
      keyboardType = TextInputType.emailAddress;
      inputFormatters = null;
    }
    return Container(
      width: widget.width,
      height: widget.height,
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: widget.controller,
        obscureText: widget.isPasswordType && !isPasswordVisible,
        enableSuggestions: !widget.isPasswordType,
        autocorrect: !widget.isPasswordType,
        decoration: InputDecoration(
          prefixIcon: widget.icon != null
              ? Padding(
            padding: EdgeInsets.only(left: dimensions.height8 ),
            child: Icon(
              widget.icon,
              color: Color(0xFF058FFF),
            ),
          )
              : null,
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
          contentPadding: EdgeInsets.symmetric(
              horizontal: dimensions.height8 * 2, vertical: 0),
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: TextStyle(
            color: Colors.black38, // Change the color to match the focused border color
            fontSize: 14,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          labelStyle:TextStyle(
            color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.height / 4),
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.height / 4),
            borderSide: BorderSide(color: Color(0xFF7A7A7A)),
          ),
        ),
      ),
    );
  }
}

