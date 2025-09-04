import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/models/user_details.dart';
import '../data/providers/bottom_nav_bar_provider.dart';
import '../data/providers/school_repository.dart';
import '../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';

enum userType { student, teacher }

enum InputType { email, phone, pinCode, all }

enum deliveryStatus {
  Initiated,
  Processed,
  Packed,
  Out_For_Delivery,
  Delivered,
  Cancelled,
  Replacement,
  Not_Placed,
  Canceled
}

class AppConstants {
  static late MainUserDetails userData;
  static bool isLogin = false;
  static String location = '';
  static String fcmToken = '';

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: SpinKitChasingDots(
              size: 24,
              color: AppColors.primaryColor,
            ),
          );
        });
  }

  // Modern Snackbar inspired by iOS notifications and Material Design 3
  static Future<void> showSnackBarTop(
      BuildContext context, String text, Color color, IconData icon,
      {int time = 3}) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final screenWidth = MediaQuery.of(context).size.width;

    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: time),
      content: TweenAnimationBuilder(
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.8, end: 1.0),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 60,
                maxWidth: screenWidth - 40,
              ),
              decoration: BoxDecoration(
                // Glass morphism effect
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  // Primary shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  // Secondary shadow for depth
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 40,
                    offset: Offset(0, 16),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    // Subtle gradient overlay
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      // Icon with status-based styling
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _getIconBackgroundColor(color),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 16),
                      // Message text
                      Expanded(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                            height: 1.4,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Modern bottom snackbar with enhanced visual appeal
  static Future<void> showSnackBar(
      BuildContext context, String text, Color color, IconData icon,
      {int time = 3}) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final screenWidth = MediaQuery.of(context).size.width;
    final isSuccess = color == AppColors.green || color == Colors.green;
    final isError = color == AppColors.error || color == Colors.red;

    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
        bottom: 100,
        left: 20,
        right: 20,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: time),
      content: TweenAnimationBuilder(
        duration: Duration(milliseconds: 400),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 64,
                  maxWidth: screenWidth - 40,
                ),
                decoration: BoxDecoration(
                  // Dynamic background based on message type
                  color: _getSnackbarBackgroundColor(color),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: color.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    // Colored glow effect
                    BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    // Standard shadow
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Animated background pattern
                    if (isSuccess) _buildSuccessPattern(),
                    if (isError) _buildErrorPattern(),

                    // Content
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          // Status indicator with animation
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 600),
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            builder: (context, double iconScale, child) {
                              return Transform.scale(
                                scale: iconScale,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    icon,
                                    color: color,
                                    size: 22,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 16),

                          // Message content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _getMessageTitle(color),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.95),
                                    height: 1.3,
                                    letterSpacing: -0.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Modern close button
                          GestureDetector(
                            onTap: () => ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar(),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white.withOpacity(0.8),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Premium cart snackbar inspired by modern e-commerce apps
  static Future<void> showCartSnackBar(BuildContext context) async {
var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){
          context.read<BottomNavigationBarProvider>().setSelectedIndex(3);
          Navigator.pushNamed(context,  MainScreen.route);
        },
        child: Container(
          width: 270,
          height: 60,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFF444444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0xFF39A7FF),
                // blurRadius: 12,
                offset: Offset(0, 5),
                // spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(text: 'Added to Cart', fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFFF9F9F9),),
              ReusableText(text: 'Go to Cart', fontSize: 16,fontWeight: FontWeight.w700,color:Color(0xFF39A7FF),)
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  // Helper methods for dynamic styling
  static Color _getIconBackgroundColor(Color statusColor) {
    if (statusColor == AppColors.green || statusColor == Colors.green) {
      return Color(0xFFE8F5E8);
    } else if (statusColor == AppColors.error || statusColor == Colors.red) {
      return Color(0xFFFFEBEE);
    } else if (statusColor == AppColors.primaryColor) {
      return AppColors.primaryColor.withOpacity(0.1);
    }
    return statusColor.withOpacity(0.1);
  }

  static Color _getSnackbarBackgroundColor(Color statusColor) {
    if (statusColor == AppColors.green || statusColor == Colors.green) {
      return Color(0xFF2E7D32);
    } else if (statusColor == AppColors.error || statusColor == Colors.red) {
      return Color(0xFFD32F2F);
    } else if (statusColor == AppColors.primaryColor) {
      return AppColors.primaryColor;
    }
    return statusColor;
  }

  static String _getMessageTitle(Color statusColor) {
    if (statusColor == AppColors.green || statusColor == Colors.green) {
      return 'Success';
    } else if (statusColor == AppColors.error || statusColor == Colors.red) {
      return 'Error';
    } else if (statusColor == AppColors.primaryColor) {
      return 'Info';
    }
    return 'Notification';
  }

  static Widget _buildSuccessPattern() {
    return Positioned(
      right: -20,
      top: -10,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  static Widget _buildErrorPattern() {
    return Positioned(
      right: -15,
      bottom: -15,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
