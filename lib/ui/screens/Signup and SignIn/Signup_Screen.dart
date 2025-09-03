import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_verification_screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/phone_otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/font_family.dart';
import '../../../data/services/phone_otp_service.dart';
import '../../../data/services/otp_service.dart';
import '../../../widgets/text and textforms/newLoginTextForm.dart';

enum AuthMethod { email, phone }

class SignUp extends StatefulWidget {
  static const route = '/signUpRoute';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();

  AuthMethod selectedAuthMethod = AuthMethod.email;
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Safely dispose of TabController before popping
        try {
          if (_tabController.index != null) {
            _tabController.animateTo(0);
          }
        } catch (e) {
          print('TabController disposal warning: $e');
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5FAFF),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5FAFF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () {
              // Navigate directly to SignIn screen instead of trying to pop
              Navigator.pushReplacementNamed(context, SignIn.route);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 2.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(),

                SizedBox(height: 3.h),

                // Name Field
                _buildNameField(),

                SizedBox(height: 2.5.h),

                // Authentication Method Tabs
                _buildAuthTabs(),

                SizedBox(height: 2.5.h),

                // Dynamic Form Fields
                _buildFormFields(),

                SizedBox(height: 4.h),

                // Send OTP Button
                _buildSendOTPButton(),

                SizedBox(height: 3.h),

                // Sign In Option
                _buildSignInOption(),

                SizedBox(height: 2.h),

                // Terms and Policy
                _buildTermsSection(),

                SizedBox(height: 2.h), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.openSans.name,
            color: const Color(0xFF121212),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Create account and choose favorite menu',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Container(
      width: double.infinity,
      child: CustomLoginForm(
        width: 100.w,
        height: 7.h,
        controller: _nameTextController,
        hintText: 'Your Name',
        labelText: 'Name',
        isPasswordType: false,
        type: InputType.all,
        icon: Icons.person_outline,
      ),
    );
  }

  Widget _buildAuthTabs() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        dividerColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            selectedAuthMethod =
                index == 0 ? AuthMethod.email : AuthMethod.phone;
          });
        },
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, size: 20.sp),
                SizedBox(width: 2.w),
                Text('Email'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_outlined, size: 20.sp),
                SizedBox(width: 2.w),
                Text('Phone'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return SizedBox(
      height: 18.h, // Responsive height
      child: TabBarView(
        controller: _tabController,
        children: [
          // Email Form
          _buildEmailForm(),
          // Phone Form
          _buildPhoneForm(),
        ],
      ),
    );
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: CustomLoginForm(
            width: 100.w,
            height: 7.h,
            controller: _emailTextController,
            hintText: 'Your Email',
            labelText: 'Email',
            isPasswordType: false,
            type: InputType.email,
            icon: Icons.email_outlined,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          child: CustomLoginForm(
            width: 100.w,
            height: 7.h,
            controller: _passwordTextController,
            hintText: 'Your Password',
            labelText: 'Password',
            isPasswordType: true,
            type: InputType.all,
            icon: Icons.lock_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneForm() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: CustomLoginForm(
            width: 100.w,
            height: 7.h,
            controller: _phoneTextController,
            hintText: 'Your Phone Number',
            labelText: 'Phone Number',
            isPasswordType: false,
            type: InputType.phone,
            icon: Icons.phone_outlined,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          child: CustomLoginForm(
            width: 100.w,
            height: 7.h,
            controller: _passwordTextController,
            hintText: 'Your Password',
            labelText: 'Password',
            isPasswordType: true,
            type: InputType.all,
            icon: Icons.lock_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildSendOTPButton() {
    return Container(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleSendOTP,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isLoading ? 0 : 2,
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Send OTP',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.nunito.name,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInOption() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Have an account? ',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignIn.route),
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              height: 1.4,
            ),
            children: [
              const TextSpan(text: 'By clicking Send OTP, you agree to our '),
              TextSpan(
                text: 'Terms, Data Policy.',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                // You can add gesture recognizer here for tap functionality
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSendOTP() async {
    // Validate name
    if (_nameTextController.text.trim().isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your name",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    // Validate password
    if (_passwordTextController.text.trim().length < 6) {
      AppConstants.showSnackBar(
          context,
          "Password must be at least 6 characters",
          AppColors.error,
          Icons.error_outline_rounded);
      return;
    }

    setState(() {
      isLoading = true;
    });

    if (selectedAuthMethod == AuthMethod.email) {
      await _handleEmailOTP();
    } else {
      await _handlePhoneOTP();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _handleEmailOTP() async {
    // Validate email
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailTextController.text)) {
      AppConstants.showSnackBar(context, "Enter a valid Email", AppColors.error,
          Icons.error_outline_rounded);
      return;
    }

    String email = _emailTextController.text.trim();
    String password = _passwordTextController.text.trim();
    String name = _nameTextController.text.trim();

    // Use fast OTP sending for instant response
    try {
      await OTPService.sendOTPFast(email);

      // Navigate immediately without waiting for email delivery
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

      // Show success message
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

  Future<void> _handlePhoneOTP() async {
    // Validate phone number
    String phoneNumber = _phoneTextController.text.trim();
    if (phoneNumber.isEmpty) {
      AppConstants.showSnackBar(context, "Please enter your phone number",
          AppColors.error, Icons.error_outline_rounded);
      return;
    }

    // Basic phone number validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber)) {
      AppConstants.showSnackBar(
          context,
          "Please enter a valid 10-digit phone number",
          AppColors.error,
          Icons.error_outline_rounded);
      return;
    }

    String name = _nameTextController.text.trim();
    String password = _passwordTextController.text.trim();

    // Send phone OTP using Firebase
    await PhoneOTPService.sendPhoneOTP(
      phoneNumber: phoneNumber,
      context: context,
      onCodeSent: (verificationId) {
        // Navigate to phone OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneOTPVerificationScreen(
              phoneNumber: phoneNumber,
              name: name,
              password: password,
              verificationId: verificationId,
            ),
          ),
        );
      },
      onError: (error) {
        AppConstants.showSnackBar(
            context, error, AppColors.error, Icons.error_outline_rounded);
      },
    );
  }
}
