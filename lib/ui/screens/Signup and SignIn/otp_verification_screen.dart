import 'dart:async';
import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/font_family.dart';
import 'package:bukizz/data/providers/auth/firebase_auth.dart';
import 'package:bukizz/data/services/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  static const route = '/otpVerificationRoute';
  final String email;
  final String name;
  final String password;

  const OTPVerificationScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.password,
  }) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  OtpFieldController otpController = OtpFieldController();
  String enteredOTP = '';
  bool isVerifying = false;
  Timer? countdownTimer;
  int resendCountdown = 0;
  bool canResend = true;

  @override
  void initState() {
    super.initState();
    _sendInitialOTP();
    _startResendCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void _sendInitialOTP() async {
    // Use fast OTP method for instant response
    try {
      await OTPService.sendOTPFast(widget.email);
      AppConstants.showSnackBar(
        context,
        "OTP sent to ${widget.email}",
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

  void _startResendCountdown() {
    setState(() {
      resendCountdown = 60; // 60 seconds countdown
      canResend = false;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (resendCountdown > 0) {
          resendCountdown--;
        } else {
          canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOTP() async {
    if (!canResend) return;

    // Use fast OTP method for instant resending
    try {
      await OTPService.sendOTPFast(widget.email);
      AppConstants.showSnackBar(
        context,
        "OTP resent to ${widget.email}",
        AppColors.green,
        Icons.check_circle_outline_rounded,
      );
      _startResendCountdown();
      otpController.clear();
      setState(() {
        enteredOTP = '';
      });
    } catch (e) {
      AppConstants.showSnackBar(
        context,
        "Failed to resend OTP. Please try again.",
        AppColors.error,
        Icons.error_outline_rounded,
      );
    }
  }

  void _verifyOTP() async {
    if (enteredOTP.length != 6) {
      AppConstants.showSnackBar(
        context,
        "Please enter the complete 6-digit OTP",
        AppColors.error,
        Icons.error_outline_rounded,
      );
      return;
    }

    setState(() {
      isVerifying = true;
    });

    try {
      final isValid = await OTPService.verifyOTP(widget.email, enteredOTP);

      if (isValid) {
        // OTP verified successfully, proceed with account creation
        AppConstants.showSnackBar(
          context,
          "Email verified successfully!",
          AppColors.green,
          Icons.check_circle_outline_rounded,
        );

        // Show loading dialog for account creation
        AppConstants.buildShowDialog(context);

        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.signUpWithEmailAndPassword(
          name: widget.name,
          email: widget.email,
          password: widget.password,
          context: context,
        );
      } else {
        AppConstants.showSnackBar(
          context,
          "Invalid or expired OTP. Please try again.",
          AppColors.error,
          Icons.error_outline_rounded,
        );
        otpController.clear();
        setState(() {
          enteredOTP = '';
        });
      }
    } catch (e) {
      AppConstants.showSnackBar(
        context,
        "Verification failed. Please try again.",
        AppColors.error,
        Icons.error_outline_rounded,
      );
    } finally {
      setState(() {
        isVerifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5FAFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verify Email',
          style: TextStyle(
            color: Colors.black87,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Main Content
                      Column(
                        children: [
                          _buildHeader(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.04),
                          _buildOTPInput(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.04),
                          _buildVerifyButton(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.03),
                          _buildResendSection(screenWidth, screenHeight),
                        ],
                      ),

                      // Bottom actions
                      Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          _buildChangeEmailSection(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Icon
        Container(
          width: screenWidth * 0.2,
          height: screenWidth * 0.2,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(screenWidth * 0.1),
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            size: screenWidth * 0.1,
            color: AppColors.primaryColor,
          ),
        ),

        SizedBox(height: screenHeight * 0.025),

        // Title
        Text(
          'Verify Your Email',
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.openSans.name,
            color: const Color(0xFF121212),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenHeight * 0.015),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.grey[600],
                height: 1.4,
              ),
              children: [
                const TextSpan(
                    text: 'We\'ve sent a 6-digit verification code to\n'),
                TextSpan(
                  text: widget.email,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPInput(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: OTPTextField(
        controller: otpController,
        length: 6,
        width: screenWidth * 0.88,
        fieldWidth: screenWidth * 0.12,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        textFieldAlignment: MainAxisAlignment.spaceEvenly,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 8,
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: 4,
        ),
        onCompleted: (pin) {
          setState(() {
            enteredOTP = pin;
          });
        },
        onChanged: (pin) {
          setState(() {
            enteredOTP = pin;
          });
        },
      ),
    );
  }

  Widget _buildVerifyButton(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.06,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: ElevatedButton(
        onPressed: isVerifying ? null : _verifyOTP,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isVerifying ? 0 : 2,
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
        ),
        child: isVerifying
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Flexible(
                    child: Text(
                      'Verifying...',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : Text(
                'Verify & Create Account',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.nunito.name,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }

  Widget _buildResendSection(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                size: screenWidth * 0.045,
                color: Colors.grey[600],
              ),
              SizedBox(width: screenWidth * 0.02),
              Flexible(
                child: Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          GestureDetector(
            onTap: canResend ? _resendOTP : null,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.012,
              ),
              decoration: BoxDecoration(
                color: canResend
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: canResend ? AppColors.primaryColor : Colors.grey[300]!,
                ),
              ),
              child: Text(
                canResend ? "Resend OTP" : "Resend in ${resendCountdown}s",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: canResend ? AppColors.primaryColor : Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeEmailSection(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_outlined,
                size: screenWidth * 0.045,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: screenWidth * 0.02),
              Flexible(
                child: Text(
                  'Change Email Address',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
