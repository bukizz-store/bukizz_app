import 'package:flutter/material.dart';

import '../../constants/font_family.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontFamily fontFamily;
  final FontWeight fontWeight;
  final double height;
  final double letterSpacing;
  final VoidCallback? onTap;

  ReusableText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    this.fontFamily = FontFamily.defaultFamily,
    this.fontWeight = FontWeight.w700,
    required this.height,
    this.letterSpacing = -0.72,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: fontFamily.name,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
