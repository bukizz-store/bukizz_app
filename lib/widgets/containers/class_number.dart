import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

class CustomClassContainer extends StatelessWidget {
  final double width;
  final double height;
  final String classNumber;
  final double classTextLeft;
  final double classTextRight;
  final double classTextTop;
  final double classNumberLeft;
  final double classNumberRight;
  final double classNumberTop;

  CustomClassContainer({super.key,
    required this.width,
    required this.height,
    required this.classNumber,
    required this.classTextLeft,
    required this.classTextRight,
    required this.classTextTop,
    required this.classNumberLeft,
    required this.classNumberRight,
    required this.classNumberTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF39A7FF), Color(0xFF0074D1)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              left:classTextLeft,
              right: classTextRight,
              top: classTextTop,
              child: ReusableText(text: 'CLASS', fontSize: 12,color: Color(0xCCF4F4F4),fontWeight: FontWeight.w700,height: 0.14,)
          ),
          Positioned(
              left:classNumberLeft,
              right: classNumberRight,
              top: classNumberTop,
              child: ReusableText(text: classNumber, fontSize: 36,color: Color(0xFFFDFDFD),fontWeight: FontWeight.w700,)
          )
        ],
      ),
    );
  }
}
String suffix(int number) {
  if (number >= 11 && number <= 13) {
    return '${number}th';
  }
  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}
