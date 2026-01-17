import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart'; // Import the LocationScreen

class CustomTabBar extends StatefulWidget {
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
      children: List.generate(
        3,
            (index) => GestureDetector(
          onTap: () {
            // For location tab (index 2), navigate to location screen
            if (index == 2) {
              // Navigate to the location screen
              Navigator.pushNamed(context, SelectLocation.route);
            } else {
              // For other tabs, update the current index as before
              setState(() {
                currentIndex = index;
                widget.onIndexChanged?.call(currentIndex);
              });
            }
          },
            child: Container(
              width: 110, // Increased width to better accommodate "My Location" text
              height: 48,
              // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5), // Proper padding on both axes
              decoration: BoxDecoration(
              color: currentIndex == index
                ?  Color(0xFF058FFF) // Change the color for the selected tab
                :  Color(0xFF3D3B40).withOpacity(0.05), // Change the color for other tabs
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: currentIndex == index
                  ? Color(0xFF058FFF) // Border color for selected tab
                  : Color(0xFF000000), // Border color for other tabs
                width: 1.0,
              ),
              boxShadow: currentIndex == index ? [
                BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 3,
                offset: Offset(0, 4),
                ),
              ] : null,
              ),
              child: Row(
              mainAxisAlignment: index != 1 ? MainAxisAlignment.center :  MainAxisAlignment.start, // Center alignment for consistent look
              children: [
                Container(
                width: index == 0 ? 30 : index== 2 ? 30: 45,
                height: index == 0 ? 30 : index== 2 ? 30 : 45,
                child: SvgPicture.asset(
                  index == 0 
                  ? 'assets/logo_main.svg'
                    : index == 1
                    ? 'assets/tab icons/myschool.svg'
                    : 'assets/tab icons/location.svg',// Red color for location icon only
                ),
                ), // Reduced spacing to give text more room
                SizedBox(width: index == 0 ? 8 :0), // Reduced spacing to give text more room
                Flexible(
                child: index == 2 
                  // Special styling for location tab to match the image
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'City',
                      style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == index ? Color(0xFFF9F9F9) : Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      AppConstants.location, // Fixed to use the correct variable name
                      style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == index ? Color(0xFFF9F9F9) : Colors.black,
                      fontWeight: FontWeight.w900,
                      ),
                    ),
                    ],
                  )
                  : index == 1 ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'My',
                      style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == index ? Color(0xFFF9F9F9) : Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "School", // Fixed to use the correct variable name
                      style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == index ? Color(0xFFF9F9F9) : Colors.black,
                      fontWeight: FontWeight.w900,
                      ),
                    ),
                    ],
                  ) :Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentIndex == index ? Color(0xFFF9F9F9) : Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                    )
                  ),
                )
              ],
              )
          ),
        ),
      ),
    );
  }
}
