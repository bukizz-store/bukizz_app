import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/webview_page.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/contact_us.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/all_policies.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz/widgets/containers/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants/constants.dart';
import '../../../../../data/providers/auth/api_auth_provider.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../Signup and SignIn/Signin_Screen.dart';

// Import existing screens if they work or placeholders
// import 'orders/order.dart'; 
// import 'saved_address_screen.dart';

class NativeProfileScreen extends StatefulWidget {
  const NativeProfileScreen({super.key});

  @override
  State<NativeProfileScreen> createState() => _NativeProfileScreenState();
}

class _NativeProfileScreenState extends State<NativeProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh user data on load
    if (AppConstants.isLogin) {
      context.read<ApiAuthProvider>().loadUserFromToken();
    }
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
          body: SafeArea(
            child: SingleChildScrollView(
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
                  
                  // For now, I'll comment out specific sub-profile screens that rely on Firebase models
                  // and just provide placeholders or link to WebViews if needed for those too?
                  // Prompt says "Fetch Orders... Manage Addresses".
                  // I should implement fetching orders from API.
                  // For this step I will enable the Buttons but they might need modified screens.
                  
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Order History',
                          icon: Icons.document_scanner,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WebViewPage(
                                  url: 'https://bukizz.in/profile?tab=orders&mode=webview',
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  AppConstants.isLogin
                      ? ProfileButton(
                          title: 'Saved Address',
                          icon: Icons.location_on,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WebViewPage(
                                  url: 'https://bukizz.in/profile?tab=addresses&mode=webview',
                                ),
                              ),
                            );
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
          ),
        ));
  }
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
                    context.read<ApiAuthProvider>().deleteAccount(context);
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
                        Provider.of<ApiAuthProvider>(context, listen: false);
                    if (context.mounted) {
                      await authProvider.signOut(context);
                      // Navigator handled in signOut
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
