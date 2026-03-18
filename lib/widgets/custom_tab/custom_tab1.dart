import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/font_family.dart';
import '../text and textforms/Reusable_text.dart';class CustomTabBar extends StatefulWidget {
  final ValueChanged<int>? onIndexChanged;

  const CustomTabBar({Key? key, this.onIndexChanged}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Shop Tab
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = 0;
              widget.onIndexChanged?.call(0);
            });
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.transparent, // Removed background
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: SvgPicture.asset('assets/logo.svg'),
                ),
                SizedBox(width: 8),
                ReusableText(
                  text: 'bukizz',
                  fontSize: 24,
                  color: Color(0xFF00579E), // Bukizz Blue
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.openSans,
                ),
              ],
            ),
          ),
        ),

        // Location Tab
        GestureDetector(
          onTap: () {
             Navigator.pushNamed(context, SelectLocation.route);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color(0xFFE8E8E8),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Color(0xFF00579E), size: 24),
                SizedBox(width: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF7A7A7A),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 100),
                      child: Text(
                        AppConstants.location.isEmpty ? 'Select City' : AppConstants.location,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF121212),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: Color(0xFF121212), size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
