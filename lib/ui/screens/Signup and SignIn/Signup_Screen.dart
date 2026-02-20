import 'package:bukizz/data/providers/auth/api_auth_provider.dart';
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

import 'package:bukizz/widgets/double_back_to_exit_wrapper.dart';

class SignUp extends StatefulWidget {
  static const route = '/signUpRoute';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  
  bool isLoading = false;

  void _handleSignup() async {
    if (_nameTextController.text.trim().isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your name",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    if (_emailController.text.trim().isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text.trim())) {
      AppConstants.showSnackBar(context, "Please enter a valid email",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    if (_phoneController.text.trim().isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(_phoneController.text.trim())) {
      AppConstants.showSnackBar(context, "Please enter a valid 10-digit phone number",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    if (_passwordTextController.text.trim().length < 6) {
      AppConstants.showSnackBar(context, "Password must be at least 6 characters",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var authProvider = Provider.of<ApiAuthProvider>(context, listen: false);
      await authProvider.signUp(
        _nameTextController.text.trim(),
        _emailController.text.trim(),
        _passwordTextController.text.trim(),
        _phoneController.text.trim(),
        context,
      );
    } catch (e) {
       // Error handling is done in provider, but just in case
       print("Signup Screen Error: $e");
    } finally {
      if(mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return DoubleBackToExitWrapper(
      child: Scaffold(
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
        body: SafeArea(
          child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                dimensions.width24,
                0,
                dimensions.width24,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 30.w,
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
                    controller: _emailController, 
                    hintText: 'Your Email', 
                    labelText: 'Email', 
                    isPasswordType: false, 
                    type: InputType.email,
                    icon: Icons.email_outlined,
                  ),
  
                  SizedBox(height: dimensions.height16),
  
                  CustomLoginForm(
                    width: 90.sp, 
                    height: 30.sp, 
                    controller: _phoneController, 
                    hintText: 'Your Phone Number', 
                    labelText: 'Phone', 
                    isPasswordType: false, 
                    type: InputType.phone,
                    icon: Icons.phone_outlined,
                  ),
  
                  SizedBox(height: dimensions.height16),
  
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
                    onPressed: isLoading ? () {} : _handleSignup, 
                    buttonText: isLoading ? 'Creating Account...' : 'Create Account',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    buttonColor: isLoading ? Colors.grey[300] : Color(0xFF058FFF), 
                  ),
  
                  SizedBox(height: dimensions.height24),
  
                  signUpOption('Already have an account?', 'Sign In', context, SignIn.route),
  
                  SizedBox(height: dimensions.height16),
  /*
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
  */
                  SizedBox(height: dimensions.height24 * 3),
                ],
              ),
            ),
          ),
      ),
    )));
  }
}
