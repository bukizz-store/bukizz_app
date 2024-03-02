import 'package:flutter/material.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/services.dart';

class CustomTextForm extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String labelText;
  final bool isPhoneNo;
  final bool isPinCode;
  final bool isEmail;

  CustomTextForm({
    required this.width,
    required this.height,
    required this.controller,
    required this.hintText,
    this.icon,
    this.labelText = '',
    this.isPhoneNo = false,
    this.isPinCode = false,
    this.isEmail = true,
  });

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    List<TextInputFormatter>? inputFormatters;

    if (isPinCode) {
      keyboardType = TextInputType.number;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)];
    } else if (isPhoneNo) {
      keyboardType = TextInputType.phone;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)];
    } else {
      keyboardType = TextInputType.emailAddress;
      inputFormatters = null;
    }

    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              icon,
              color: Color(0xFF058FFF),
            ),
          )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(
            color: Color(0xFF7A7A7A),
            fontSize: 14,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height / 2),
            borderSide: BorderSide(color: Color(0xFF7A7A7A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height / 2),
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

