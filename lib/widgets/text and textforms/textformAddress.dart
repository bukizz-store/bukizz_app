import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;

  CustomTextForm({
    required this.width,
    required this.height,
    required this.controller,
    required this.hintText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
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
          hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
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

