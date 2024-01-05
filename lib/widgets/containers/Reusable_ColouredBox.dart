import 'package:flutter/material.dart';


class ReusableColoredBox extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  ReusableColoredBox({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.borderColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // padding:EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: child,
    );
  }
}

