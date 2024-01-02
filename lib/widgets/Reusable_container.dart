import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final double width;
  final double height;
  final Function() child;
  final Color? borderColor;

  ReusableContainer({
    Key? key,
    required this.width,
    required this.child,
    required this.height,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: child(),
      ),
    );
  }
}
