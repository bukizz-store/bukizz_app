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
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        keyboardType: isPhoneNo
            ? TextInputType.phone
            : (isEmail ? TextInputType.emailAddress : TextInputType.number),
        inputFormatters: isPinCode
            ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)]
            : (isEmail ? [] : [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]),
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Padding(
            padding: EdgeInsets.only(left: dimensions.height8 * 2),
            child: Icon(
              icon,
              color: Color(0xFF058FFF),
            ),
          )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(
            color: Color(0xFF7A7A7A),
            fontSize: 14,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w400,
            height: 0,
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
