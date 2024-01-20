import 'package:flutter/material.dart';

import '../../constants/font_family.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontFamily fontFamily;
  final FontWeight fontWeight;
  final double? height;
  final double letterSpacing;
  final TextOverflow overflow;
  final VoidCallback? onTap;

  ReusableText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    this.fontFamily = FontFamily.defaultFamily,
    this.fontWeight = FontWeight.w700,
    this.height = 0.11,
    this.letterSpacing = -0.72,
    this.overflow = TextOverflow.ellipsis, // Default overflow
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        overflow: overflow,
        softWrap: true,
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
