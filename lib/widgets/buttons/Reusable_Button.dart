import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final double letterSpacing;
  final IconData? iconData;
  final String? imagePath; // Optional asset image path

  const ReusableElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = const Color(0xFF058FFF),
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontFamily = 'Open Sans',
    this.fontWeight = FontWeight.w700,
    this.letterSpacing = 0.30,
    this.iconData,
    this.imagePath, // Include the optional asset image path in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  imagePath!,
                  height: 24, // Adjust the height as needed
                  width: 24, // Adjust the width as needed
                  // color: textColor,
                ),
              ),
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  iconData,
                  color: textColor,
                ),
              ),
            Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
