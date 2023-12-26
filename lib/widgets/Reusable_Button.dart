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

  const ReusableElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = const Color(0xFF03045E),
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontFamily = 'Open Sans',
    this.fontWeight = FontWeight.w700,
    this.letterSpacing = 0.30,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
