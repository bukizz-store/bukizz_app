import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/profile.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/contact_us.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/all_policies.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/saved_address_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/utils/crashlytics_service.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz/widgets/containers/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants/constants.dart';
import '../../../../../data/providers/auth/firebase_auth.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../data/repository/my_orders.dart';
import '../../../Signup and SignIn/Signin_Screen.dart';
import 'orders/order.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return PopScope(
        canPop: false,
        onPopInvoked: (val) {
          context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
          return;
        },
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context
                      .read<BottomNavigationBarProvider>()
                      .setSelectedIndex(0);
                  Navigator.pushNamed(context, MainScreen.route);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
              ),
              title: ReusableText(
                text: 'Profile',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          body: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: dimensions.height10,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: dimensions.height10 * 5.5,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset('assets/user.svg'),
                    ),
                  ),
                  SizedBox(
                    height: dimensions.height10,
                  ),
                  ReusableText(
                    text: AppConstants.isLogin
                        ? AppConstants.userData.name
                        : 'Guest User',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: dimensions.height10 * 2,
                  ),
                  ReusableText(
                    text:
                        AppConstants.isLogin ? AppConstants.userData.email : '',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF121212).withOpacity(0.6),
                  ),
                  SizedBox(
                    height: dimensions.height16,
                  ),
                  ReusableText(
                      text: AppConstants.isLogin
                          ? AppConstants.userData.address.phone
                          : '',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF121212).withOpacity(0.6)),
                  SizedBox(
                    height: dimensions.height10 * 5,
                  ),
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Profile',
                          icon: Icons.home,
                          onTap: () {
                            Navigator.pushNamed(context, ProfileScreen.route);
                          },
                        )
                      : Container(),
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Order History',
                          icon: Icons.document_scanner,
                          onTap: () {
                            context.read<MyOrders>().fetchOrders();
                            Navigator.pushNamed(context, OrderScreen.route);
                          },
                        )
                      : Container(),
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Saved Address',
                          icon: Icons.location_on,
                          onTap: () {
                            Navigator.pushNamed(
                                context, SavedAddressScreen.route);
                          },
                        )
                      : Container(),
                  ProfileButton(
                    title: 'My City',
                    icon: Icons.location_city,
                    onTap: () {
                      Navigator.pushNamed(context, SelectLocation.route);
                    },
                  ),
                  ProfileButton(
                    title: 'Contact Us',
                    icon: Icons.phone,
                    onTap: () {
                      Navigator.pushNamed(context, ContactUsScreen.route);
                    },
                  ),
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Delete Your Account',
                          icon: Icons.delete,
                          onTap: () {
                            DeletePopUp(context);
                          },
                        )
                      : Container(),
                  ProfileButton(
                    title: 'Terms, Policies & Licenses',
                    icon: Icons.policy,
                    onTap: () {
                      Navigator.pushNamed(context, AllPoliciesScreen.route);
                    },
                  ),
                  // Firebase Crashlytics Test Section
                  SizedBox(height: dimensions.height10),
                //   Container(
                //     width: dimensions.screenWidth,
                //     padding:
                //         EdgeInsets.symmetric(horizontal: dimensions.width16),
                //     child: ReusableText(
                //       text: 'Crashlytics Testing (Debug Only)',
                //       fontSize: 14,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.orange,
                //     ),
                //   ),
                //   SizedBox(height: dimensions.height10),
                //   ProfileButton(
                //     title: 'Send Test Log',
                //     icon: Icons.bug_report,
                //     iconColor: Colors.green,
                //     iconBackgroundColor: Color(0xFFE8F5E8),
                //     onTap: () {
                //       CrashlyticsService.log(
                //           'User triggered test log from profile');
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content:
                //               Text('Test log sent to Firebase Crashlytics!'),
                //           backgroundColor: Colors.green,
                //         ),
                //       );
                //     },
                //   ),
                //   ProfileButton(
                //     title: 'Send Test Error',
                //     icon: Icons.warning,
                //     iconColor: Colors.orange,
                //     iconBackgroundColor: Color(0xFFFFF3CD),
                //     onTap: () {
                //       try {
                //         throw Exception(
                //             'Test non-fatal error from profile screen');
                //       } catch (error, stackTrace) {
                //         CrashlyticsService.recordError(
                //           error,
                //           stackTrace,
                //           reason: 'User triggered test non-fatal error',
                //           fatal: false,
                //         );
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content:
                //                 Text('Test error recorded in Crashlytics!'),
                //             backgroundColor: Colors.orange,
                //           ),
                //         );
                //       }
                //     },
                //   ),
                //   ProfileButton(
                //     title: 'Test Fatal Crash (Use Carefully!)',
                //     icon: Icons.error,
                //     iconColor: Colors.red,
                //     iconBackgroundColor: Color(0xFFF8D7DA),
                //     onTap: () {
                //       showTestCrashDialog(context);
                //     },
                //   ),
                //   SizedBox(height: dimensions.height10),
                  SafeArea(child:Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width16,
                    vertical: dimensions.height16
                      ),
                    child: InkWell(
                    onTap: AppConstants.isLogin
                        ? () {
                            showCustomAboutDialog(context);
                          }
                        : () {
                            context
                                .read<BottomNavigationBarProvider>()
                                .setSelectedIndex(0);
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignIn.route, (route) => false);
                          },
                    child: Container(
                        width: dimensions.screenWidth,
                        height: dimensions.height48,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF058FFF)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppConstants.isLogin
                                ? Icon(
                                    Icons.logout,
                                    color: Color(0xFF058FFF),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Color(0xFF058FFF),
                                  ),
                            ReusableText(
                              text: AppConstants.isLogin ? 'Logout' : 'Sign In',
                              fontSize: 16,
                              color: Color(0xFF058FFF),
                            )
                          ],
                        )),
                  )
                ,
                    ),)
                  ],
              ),
            ),
          ),
        ));
  }
}

void showCustomAboutDialog(BuildContext context) {
  Dimensions dimensions = Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Center(
            child: Column(
              children: [
                ReusableText(
                  text: 'Are You Sure',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF121212),
                ),
                SizedBox(
                  height: dimensions.height10 * 2,
                ),
                ReusableText(
                  text: 'You are about to logout from the app',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF444444),
                ),
              ],
            ),
          ),
          content: Container(
            // width: dimensions.width10*35.6,
            height: dimensions.height10 * 8.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    var authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    AppConstants.isLogin = false;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLogin', false);
                    if (context.mounted) {
                      authProvider.signOut(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignIn.route, (route) => false);
                    }
                  },
                  child: Container(
                    width: dimensions.width10 * 11.5,
                    height: dimensions.height10 * 3.5,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: 'Logout',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00579E),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: dimensions.width16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: dimensions.width10 * 11.5,
                    height: dimensions.height10 * 3.5,
                    decoration: ShapeDecoration(
                      color: Color(0xFF058FFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: 'Cancel',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
    },
  );
}

void DeletePopUp(BuildContext context) {
  Dimensions dimensions = Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Center(
            child: Column(
              children: [
                ReusableText(
                  text: 'Are You Sure?',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF121212),
                ),
                SizedBox(
                  height: dimensions.height10,
                ),
                ReusableText(
                  text: 'to delete your account permanently',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF444444),
                ),
              ],
            ),
          ),
          content: Container(
            // width: dimensions.width10*35.6,
            height: dimensions.height10 * 8.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    context.read<AuthProvider>().deleteAccount(context);
                  },
                  child: Container(
                    width: dimensions.width10 * 11.5,
                    height: dimensions.height10 * 3.5,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: 'Delete',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00579E),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: dimensions.width10 * 11.5,
                    height: dimensions.height10 * 3.5,
                    decoration: ShapeDecoration(
                      color: Color(0xFF058FFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: 'Cancel',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
    },
  );
}

void showTestCrashDialog(BuildContext context) {
  Dimensions dimensions = Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Column(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
                size: 48,
              ),
              SizedBox(height: dimensions.height10),
              ReusableText(
                text: 'Warning: Fatal Crash Test',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF121212),
              ),
              SizedBox(height: dimensions.height10),
              ReusableText(
                text:
                    'This will forcefully crash the app to test Firebase Crashlytics. The app will close immediately.',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF444444),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        content: Container(
          height: dimensions.height10 * 8.5,
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      // Send a test crash report without actually crashing
                      await CrashlyticsService.sendTestCrashReport();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('🔥 Test crash report sent to Firebase!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: Container(
                      width: dimensions.width10 * 11.5,
                      height: dimensions.height10 * 3.5,
                      decoration: ShapeDecoration(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: ReusableText(
                          text: 'Test Report',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Force a fatal crash for testing
                      CrashlyticsService.testCrash();
                    },
                    child: Container(
                      width: dimensions.width10 * 11.5,
                      height: dimensions.height10 * 3.5,
                      decoration: ShapeDecoration(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: ReusableText(
                          text: 'Fatal Crash',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: dimensions.height10),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: dimensions.screenWidth * 0.7,
                  height: dimensions.height10 * 3.5,
                  decoration: ShapeDecoration(
                    color: Color(0xFF058FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: ReusableText(
                      text: 'Cancel',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
