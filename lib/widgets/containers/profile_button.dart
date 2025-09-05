import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../text and textforms/Reusable_text.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const ProfileButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = const Color(0xFF0590FF),
    this.iconBackgroundColor = const Color(0xFFCCE8FF),
  });

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: dimensions.height10 * 8.5,
        width: dimensions.screenWidth,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: dimensions.width10 * 2.5,
                      backgroundColor: iconBackgroundColor,
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: dimensions.height10),
                    ReusableText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF121212),
                    )
                  ],
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
