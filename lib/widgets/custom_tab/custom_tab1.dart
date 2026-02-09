import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bukizz/constants/constants.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.transparent, // Removed background
              borderRadius: BorderRadius.circular(12.0),
              // Removed border and box shadow as per "remove the background" instruction implies simpler look
              // but keeping structure if needed. User said "remove the background that we are using modify this"
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 43,
                  height: 43,
                  child: SvgPicture.asset('assets/logo_main.svg'),
                ),
                SizedBox(width: 8),
                ReusableText(
                  text: 'bukizz',
                  fontSize: 24,
                  color: currentIndex == 0 ? Color(0xFF000000) : Color(0xFF00000), // Adjusted active color for text since background is gone
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),

        // Spacer to maintain distance similar to previous layout if needed,
        // or just rely on spaceEvenly with 2 items.
        // The user said "keep the distance as it is".
        // Previous: [Item] [Item] [Item] with spaceEvenly.
        // Now: [Item] [Item] with spaceEvenly will put them further apart.
        // To keep similar distance, we can put a SizedBox in the middle
        SizedBox(width: 110,), 

        // Location Tab
        GestureDetector(
          onTap: () {
             Navigator.pushNamed(context, SelectLocation.route);
          },
          child: Container(
            width: 130,
            height: 48,
            decoration: BoxDecoration(
              color: currentIndex == 2
                  ? Color(0xFF058FFF)
                  : Color(0xFF3D3B40).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: currentIndex == 2 ? Color(0xFF058FFF) : Color(0xFF000000),
                width: 1.0,
              ),
              boxShadow: currentIndex == 2
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 3,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 30,
                  child: SvgPicture.asset('assets/tab icons/location.svg'),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: TextStyle(
                          fontSize: 12,
                          color: currentIndex == 2 ? Color(0xFFF9F9F9) : Color(0xFF444444),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        AppConstants.location,
                        style: TextStyle(
                          fontSize: 15,
                          color: currentIndex == 2 ? Color(0xFFF9F9F9) : Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
