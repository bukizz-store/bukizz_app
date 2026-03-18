import 'dart:io';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/reset_password.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/phone_login_otp_screen.dart';
import 'package:bukizz/data/services/phone_otp_service.dart';
import 'package:bukizz/widgets/text%20and%20textforms/newLoginTextForm.dart';
// Add imports for privacy policy and terms pages
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/privacy_policy.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../data/providers/auth/api_auth_provider.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/buttons/Reusable_Button.dart';
import '../../../widgets/containers/Reusable_container.dart';
import '../../../widgets/signup_text_widget.dart';
import '../../../widgets/text and textforms/Reusable_text.dart';
import '../HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/widgets/double_back_to_exit_wrapper.dart';
import 'Signup_Screen.dart';

class SignIn extends StatefulWidget {
  static const route = '/signInRoute';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  bool _isPhoneLogin = false;
  
  Future<void> signIn(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      // If location is enabled, navigate to the main screen
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, (route) => false);
    } else {
      // If location is not enabled, navigate to the location screen
      Navigator.pushNamedAndRemoveUntil(
          context, LocationScreen.route, (route) => false);
    }
  }

  bool _isPhoneInput(String input) {
    // Remove any non-digit characters
    String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if input starts with phone number patterns or has only digits
    // Hide password field immediately when user starts typing digits
    if (digitsOnly.isNotEmpty && input.trim() == digitsOnly) {
      // If input contains only digits, treat as phone input
      return true;
    }
    
    // Also check for common phone number starting patterns
    if (digitsOnly.isNotEmpty && RegExp(r'^[6-9]').hasMatch(digitsOnly)) {
      return true;
    }
    
    return false;
  }

  bool _isPhoneNumber(String input) {
    // Remove any non-digit characters
    String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if it's a complete 10-digit number (Indian mobile number format)
    return RegExp(r'^[6-9][0-9]{9}$').hasMatch(digitsOnly);
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _updateLoginType() {
    setState(() {
      // Use the new _isPhoneInput method for immediate detection
      _isPhoneLogin = _isPhoneInput(_emailOrPhoneController.text);
      
      // Clear password field when switching to phone input
      if (_isPhoneLogin) {
        _passwordTextController.clear();
      }
    });
  }

  void _handleLogin() async {
    String input = _emailOrPhoneController.text.trim();

    if (input.isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your email or phone number",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    var authProvider = Provider.of<ApiAuthProvider>(context, listen: false);

    if (_isPhoneNumber(input)) {
      // Handle phone number login with OTP (no password needed)
      String phoneNumber = input.replaceAll(RegExp(r'[^\d]'), '');
      
      // Show loading
      AppConstants.buildShowDialog(context);

      // Send OTP for phone login
      await PhoneOTPService.sendPhoneOTP(
        phoneNumber: phoneNumber,
        context: context,
        onCodeSent: (verificationId) {
          // Dismiss loading dialog
          Navigator.of(context).pop();
          
          // Navigate to phone login OTP screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneLoginOTPScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ),
            ),
          );
        },
        onError: (error) {
          // Dismiss loading dialog
          Navigator.of(context).pop();
          AppConstants.showSnackBar(
              context, error, AppColors.error, Icons.error_outline_rounded);
        },
      );
    } else if (_isValidEmail(input)) {
      // Handle email login (password required)
      String password = _passwordTextController.text.trim();
      
      if (password.isEmpty) {
        AppConstants.showSnackBar(context, "Please enter your password",
            AppColors.error, Icons.error_outline_rounded);
        return;
      }
      
      AppConstants.buildShowDialog(context);
      await authProvider.signInWithEmailAndPassword(input, password, context);
    } else {
      AppConstants.showSnackBar(context, "Please enter a valid email or phone number",
          AppColors.error, Icons.error_outline_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    //dimension construction
    Dimensions dimensions = Dimensions(context);
    var authProvider = Provider.of<ApiAuthProvider>(context, listen: false);
    return DoubleBackToExitWrapper(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                dimensions.width24,
                // 0,
                dimensions.height16,
                dimensions.width24,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //welcome text //done
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(SelectLocation.route, (route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.productButtonSelectedBorder),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 33.w,
                      height: 4.h,
                      child: Row(
                        children: [
                          ReusableText(text: "Skip Login", fontSize: 16),
                          Icon(Icons.arrow_circle_right_outlined)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                                  Center(
                    child: Container(
                      width: 30.w,
                      // height: 10.h,
                      child: SvgPicture.asset('assets/logo.svg'),
                    ),
                  ),
                  SizedBox(height: 20.sp,),
                  ReusableContainer(
                    width: dimensions.width327,
                    height: dimensions.height32,
                    child: () {
                      return ReusableText(
                        text: 'Welcome Back 👋',
                        fontSize: 24,
                        height: 0.06,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.openSans,
                        color: Color(0xFF121212),
                      );
                    },
                  ),
  
                  //sign to your account text //done
                  ReusableContainer(
                    width: dimensions.width327,
                    height: dimensions.height24,
                    child: () {
                      return ReusableText(
                        text: 'Sign to your account',
                        fontSize: 16,
                        height: 0.09,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      );
                    },
                  ),
  
                   SizedBox(height: 10.sp,),
                  //Email or Phone Form
                  CustomLoginForm(
                    width: 90.sp, 
                    height: 30.sp, 
                    controller: _emailOrPhoneController, 
                    hintText: 'Your Email or Phone Number', 
                    labelText: 'Email / Phone', 
                    isPasswordType: false, 
                    type: InputType.all,
                    icon: _isPhoneNumber(_emailOrPhoneController.text) 
                        ? Icons.phone_outlined 
                        : Icons.email_outlined,
                    onChanged: (value) => _updateLoginType(), // Add onChanged callback
                  ),
  
                  SizedBox(
                    height: dimensions.height10,
                  ),
  
                  // Show password field only for email login
                  if (!_isPhoneLogin) ...[
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    //password form
                    CustomLoginForm(width: 90.sp, height: 30.sp, controller: _passwordTextController, hintText: 'Your Password', labelText: 'Password', isPasswordType: true, type: InputType.all,icon: Icons.password,),
  
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ForgotPasswordScreen.route);
                        },
                        child: ReusableText(
                          text: "Forget Password ?",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        )),
                  ] else ...[
                    // Show info for phone login
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sms_outlined, color: Colors.green.shade600, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'We\'ll send an OTP to verify your phone number',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
  
                  SizedBox(
                    height: dimensions.height10*0.5,
                  ),
  
                  // Add Terms & Conditions and Privacy Policy links
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(text: 'By continuing you agree to bukizz\'s '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, TermsOfUse.route);
                              },
                              child: Text(
                                'Terms of Use',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: ' and '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PrivacyPolicy.route);
                              },
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
  
                  SizedBox(
                    height: dimensions.height10,
                  ),
  
                  //login button
                  ReusableElevatedButton(
                    width: dimensions.width327,
                    height: dimensions.height48,
                    onPressed: _handleLogin,
                    buttonText: 'Login',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
  
                  SizedBox(
                    height: dimensions.height24,
                  ),
  
                  signUpOption('Don\'t have an account?', 'Sign Up', context,
                      SignUp.route),
  
                  SizedBox(
                    height: dimensions.height16,
                  ),
  
                  //seperation lines with text or with
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE8E8E8), //color of line
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: ReusableText(
                                text: 'Or with',
                                fontSize: 14,
                                height: 0.10,
                                color: const Color(0xFFA5A5A5),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE8E8E8), // color of the line
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
  
                  SizedBox(
                    height: dimensions.height16,
                  ),
  
                  //Sign in with google
                  Consumer<ApiAuthProvider>(
                    builder: (context, auth, child) {
                      return ReusableElevatedButton(
                              shadowColor: Colors.grey.withOpacity(0.6),
                              width: dimensions.width327,
                              height: dimensions.height48,
                              isLoading: auth.isGoogleLoading,
                              onPressed: () {
                                if (!auth.isGoogleLoading && !auth.isAppleLoading) {
                                  auth.googleSignInMethod(context);
                                }
                              },
                              buttonText: 'Sign in with Google',
                              buttonColor: Colors.white,
                              textColor: Color(0xFF121212),
                              fontSize: 14,
                              fontFamily: FontFamily.nunito.name,
                              fontWeight: FontWeight.w400,
                              imagePath: 'assets/google.png',
                              borderColor: Colors.black38,
                            );
                    },
                  ),
                  SizedBox(
                    height: dimensions.height8 * 2,
                  ),

                  // Sign in with Apple (iOS only)
                  if (Platform.isIOS) ...[
                    Consumer<ApiAuthProvider>(
                      builder: (context, auth, child) {
                        return ReusableElevatedButton(
                                shadowColor: Colors.grey.withOpacity(0.6),
                                width: dimensions.width327,
                                height: dimensions.height48,
                                isLoading: auth.isAppleLoading,
                                onPressed: () {
                                  if (!auth.isAppleLoading && !auth.isGoogleLoading) {
                                    auth.appleSignInMethod(context);
                                  }
                                },
                                buttonText: 'Sign in with Apple',
                                buttonColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14,
                                fontFamily: FontFamily.nunito.name,
                                fontWeight: FontWeight.w400,
                                iconData: Icons.apple,
                                borderColor: Colors.black,
                              );
                      },
                    ),
                    SizedBox(
                      height: dimensions.height8 * 2,
                    ),
                  ],
                  
                  // Info text about login methods
                  // Container(
                  //   padding: EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue.shade50,
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(color: Colors.blue.shade200),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.info_outline, color: Colors.blue.shade600, size: 16),
                  //       SizedBox(width: 8),
                  //       Expanded(
                  //         child: Text(
                  //           'Enter your email & password for login',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.blue.shade700,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
