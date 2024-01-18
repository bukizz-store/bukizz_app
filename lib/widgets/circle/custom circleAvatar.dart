import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Widget child;

  CustomCircleAvatar({
    required this.radius,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
