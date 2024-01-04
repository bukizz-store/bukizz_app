import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final double width;
  final double height;
  final Function() child;

  ReusableContainer({
    Key? key,
    required this.width,
    required this.child,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: child(),
    );
  }
}
