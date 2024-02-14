import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final int maxLine;
  final TextAlign textAlign;

  ReusableText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    this.fontFamily = FontFamily.nunito,
    this.fontWeight = FontWeight.w700,
    this.height = 0.11,
    this.letterSpacing = -0.72,
    this.overflow = TextOverflow.ellipsis, // Default overflow
    this.onTap,
    this.maxLine = 1,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        overflow: overflow,
        softWrap: true,
        textAlign: textAlign,
        style: GoogleFonts.nunito(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        ),
        maxLines: maxLine,
      ),
    );
  }
}
