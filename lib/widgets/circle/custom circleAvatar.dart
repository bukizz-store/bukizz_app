import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Widget child;
  final String text;
  final FontWeight fontWeight;

  CustomCircleAvatar({
    required this.radius,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.child,
    this.text='Address', this.fontWeight=FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 6,),
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: backgroundColor,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        ReusableText(text: text, fontSize: 14,fontWeight: fontWeight,)
      ],
    );
  }
}
