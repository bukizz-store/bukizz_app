import 'package:bukizz/data/providers/auth/firebase_auth.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_verification_screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/phone_otp_verification_screen.dart';
// Add imports for privacy policy and terms pages
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/privacy_policy.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/font_family.dart';
import '../../../data/services/phone_otp_service.dart';
import '../../../data/services/otp_service.dart';
import '../../../widgets/text and textforms/newLoginTextForm.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/buttons/Reusable_Button.dart';
import '../../../widgets/containers/Reusable_container.dart';
import '../../../widgets/signup_text_widget.dart';
import '../../../widgets/text and textforms/Reusable_text.dart';

class SignUp extends StatefulWidget {
  static const route = '/signUpRoute';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  
  bool _isPhoneSignup = false;
  bool isLoading = false;

  bool _isPhoneInput(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isNotEmpty && input.trim() == digitsOnly) {
      return true;
    }
    if (digitsOnly.isNotEmpty && RegExp(r'^[6-9]').hasMatch(digitsOnly)) {
      return true;
    }
    return false;
  }

  bool _isPhoneNumber(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    return RegExp(r'^[6-9][0-9]{9}$').hasMatch(digitsOnly);
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _updateSignupType() {
    setState(() {
      _isPhoneSignup = _isPhoneInput(_emailOrPhoneController.text);
      if (_isPhoneSignup) {
        _passwordTextController.clear();
      }
    });
  }

  void _handleSignup() async {
    if (_nameTextController.text.trim().isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your name",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    String input = _emailOrPhoneController.text.trim();

    if (input.isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your email or phone number",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (_isPhoneNumber(input)) {
        await _handlePhoneSignup(input);
      } else if (_isValidEmail(input)) {
        await _handleEmailSignup(input);
      } else {
        AppConstants.showSnackBar(context, "Please enter a valid email or phone number",
            AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleEmailSignup(String email) async {
    String password = _passwordTextController.text.trim();
    if (password.length < 6) {
      AppConstants.showSnackBar(
          context,
          "Password must be at least 6 characters",
          AppColors.error,
          Icons.error_outline_rounded);
      return;
    }

    String name = _nameTextController.text.trim();

    try {
      await OTPService.sendOTPFast(email);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(
            email: email,
            name: name,
            password: password,
          ),
        ),
      );

      AppConstants.showSnackBar(
        context,
        "OTP sent to $email",
        AppColors.green,
        Icons.check_circle_outline_rounded,
      );
    } catch (e) {
      AppConstants.showSnackBar(
        context,
        "Failed to send OTP. Please try again.",
        AppColors.error,
        Icons.error_outline_rounded,
      );
    }
  }

  Future<void> _handlePhoneSignup(String phoneNumber) async {
    String cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    String name = _nameTextController.text.trim();
    String dummyPassword = "phone_auth_no_password";

    String tempVerificationId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneOTPVerificationScreen(
          phoneNumber: cleanPhoneNumber,
          name: name,
          password: dummyPassword,
          verificationId: tempVerificationId,
        ),
      ),
    );

    PhoneOTPService.sendPhoneOTPFast(
      phoneNumber: cleanPhoneNumber,
      context: context,
      onCodeSent: (verificationId) {
        AppConstants.showSnackBar(
          context,
          "OTP sent to $cleanPhoneNumber",
          AppColors.green,
          Icons.check_circle_outline_rounded,
        );
      },
      onError: (error) {
        AppConstants.showSnackBar(
            context, error, AppColors.error, Icons.error_outline_rounded);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacementNamed(context, SignIn.route);
        }
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimensions.width24,
              0,
              // dimensions.height16*3.5,

              dimensions.width24,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10,),
                Center(
                  child: Container(
                    width: 30.w,
                    // height: 10.h,
                    child: SvgPicture.asset('assets/logo.svg'),
                  ),
                ),
                SizedBox(height: 10.sp,),
                ReusableContainer(
                  width: dimensions.width327,
                  height: dimensions.height32,
                  child: () {
                    return ReusableText(
                      text: 'Create Account 🎉',
                      fontSize: 24,
                      height: 0.06,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.openSans,
                      color: Color(0xFF121212),
                    );
                  },
                ),

                ReusableContainer(
                  width: dimensions.width327,
                  height: dimensions.height24,
                  child: () {
                    return ReusableText(
                      text: 'Sign up to get started',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    );
                  },
                ),

                SizedBox(height: 10.sp,),

                CustomLoginForm(
                  width: 90.sp, 
                  height: 30.sp, 
                  controller: _nameTextController, 
                  hintText: 'Your Name', 
                  labelText: 'Name', 
                  isPasswordType: false, 
                  type: InputType.all,
                  icon: Icons.person_outline,
                ),

                SizedBox(height: dimensions.height16),

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
                  onChanged: (value) => _updateSignupType(),
                ),

                SizedBox(height: dimensions.height16),

                if (!_isPhoneSignup) ...[
                  // SizedBox(height: dimensions.height10),
                  CustomLoginForm(
                    width: 90.sp, 
                    height: 30.sp, 
                    controller: _passwordTextController, 
                    hintText: 'Your Password', 
                    labelText: 'Password', 
                    isPasswordType: true, 
                    type: InputType.all,
                    icon: Icons.password,
                  ),
                ] else ...[
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

                SizedBox(height: dimensions.height10),

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

                SizedBox(height: dimensions.height10),

                ReusableElevatedButton(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: isLoading ? () {} : _handleSignup, // Pass empty function instead of null
                  buttonText: isLoading ? 'Creating Account...' : 'Create Account',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  buttonColor: isLoading ? Colors.grey[300] : null, // Change color when loading
                ),

                SizedBox(height: dimensions.height24),

                signUpOption('Already have an account?', 'Sign In', context, SignIn.route),

                SizedBox(height: dimensions.height16),

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE8E8E8),
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
                              color: Color(0xFFE8E8E8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: dimensions.height16),

                ReusableElevatedButton(
                  shadowColor: Colors.grey.withOpacity(0.6),
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () {
                    authProvider.googleSignInMethod(context);
                  },
                  buttonText: 'Sign up with Google',
                  buttonColor: Colors.white,
                  textColor: Color(0xFF121212),
                  fontSize: 14,
                  fontFamily: FontFamily.nunito.name,
                  fontWeight: FontWeight.w400,
                  imagePath: 'assets/google.png',
                  borderColor: Colors.black38,
                ),

                SizedBox(height: dimensions.height8 * 2),
                
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade600, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Enter your email for password signup or phone number for OTP signup',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
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
      ),
    );
  }
}
