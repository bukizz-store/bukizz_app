import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final String title;
  final String schoolName;
  final int starCount;
  final Color borderColor;
  final String className;
  final String subject;
  final Function() onTap;

  ReusableCard({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.title,
    required this.schoolName,
    required this.starCount,
    required this.borderColor,
    required this.className,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.50, color: borderColor),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26023E8A),
              blurRadius: 16,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 128,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
            // Image.asset(imageUrl),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF03045E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    schoolName,
                    style: const TextStyle(
                      color: Color(0xFF03045E),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Text(
                  //   'Class: $className - $subject',
                  //   style: const TextStyle(
                  //     color: Color(0xFF03045E),
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
