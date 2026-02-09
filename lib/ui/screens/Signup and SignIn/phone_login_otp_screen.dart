import 'dart:async';
import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/font_family.dart';
import 'package:bukizz/data/providers/auth/api_auth_provider.dart';
import 'package:bukizz/data/services/phone_otp_service.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class PhoneLoginOTPScreen extends StatefulWidget {
  static const route = '/phoneLoginOtpRoute';
  final String phoneNumber;
  final String verificationId;

  const PhoneLoginOTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<PhoneLoginOTPScreen> createState() => _PhoneLoginOTPScreenState();
}

class _PhoneLoginOTPScreenState extends State<PhoneLoginOTPScreen> {
  OtpFieldController otpController = OtpFieldController();
  String enteredOTP = '';
  bool isVerifying = false;
  Timer? countdownTimer;
  int resendCountdown = 0;
  bool canResend = true;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
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

    await PhoneOTPService.sendPhoneOTP(
      phoneNumber: widget.phoneNumber,
      context: context,
      onCodeSent: (verificationId) {
        AppConstants.showSnackBar(
          context,
          "OTP resent to ${widget.phoneNumber}",
          AppColors.green,
          Icons.check_circle_outline_rounded,
        );
        _startResendCountdown();
        otpController.clear();
        setState(() {
          enteredOTP = '';
        });
      },
      onError: (error) {
        AppConstants.showSnackBar(
          context,
          "Failed to resend OTP. Please try again.",
          AppColors.error,
          Icons.error_outline_rounded,
        );
      },
    );
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
      // Show loading dialog
      AppConstants.buildShowDialog(context);

      var authProvider = Provider.of<ApiAuthProvider>(context, listen: false);

      // Sign in with phone number using the entered OTP
      await authProvider.signInWithPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationId: widget.verificationId,
        smsCode: enteredOTP,
        context: context,
      );
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss loading dialog
      AppConstants.showSnackBar(
        context,
        "Login failed. Please try again.",
        AppColors.error,
        Icons.error_outline_rounded,
      );
      otpController.clear();
      setState(() {
        enteredOTP = '';
      });
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
          'Verify Phone',
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

                      // Help Section at bottom
                      Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          _buildHelpSection(screenWidth, screenHeight),
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
            Icons.phone_android_outlined,
            size: screenWidth * 0.1,
            color: AppColors.primaryColor,
          ),
        ),

        SizedBox(height: screenHeight * 0.025),

        // Title
        Text(
          'Verify Your Phone',
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.openSans.name,
            color: const Color(0xFF121212),
          ),
        ),

        SizedBox(height: screenHeight * 0.015),

        // Subtitle with phone number
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black54,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: 'We sent a verification code to\n'),
              TextSpan(
                text: widget.phoneNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOTPInput(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: OTPTextField(
        controller: otpController,
        length: 6,
        width: screenWidth,
        fieldWidth: screenWidth * 0.12,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
        ),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 12,
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: 4,
        ),
        onChanged: (pin) {
          setState(() {
            enteredOTP = pin;
          });
        },
        onCompleted: (pin) {
          setState(() {
            enteredOTP = pin;
          });
          // Auto-verify when OTP is complete
          if (pin.length == 6) {
            _verifyOTP();
          }
        },
      ),
    );
  }

  Widget _buildVerifyButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.07,
      child: ElevatedButton(
        onPressed: isVerifying || enteredOTP.length != 6 ? null : _verifyOTP,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isVerifying
            ? SizedBox(
                height: screenHeight * 0.025,
                width: screenHeight * 0.025,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Verify & Sign In',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildResendSection(double screenWidth, double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code? ",
          style: TextStyle(
            fontSize: screenWidth * 0.038,
            color: Colors.black54,
          ),
        ),
        GestureDetector(
          onTap: canResend ? _resendOTP : null,
          child: Text(
            canResend ? 'Resend' : 'Resend in ${resendCountdown}s',
            style: TextStyle(
              fontSize: screenWidth * 0.038,
              color: canResend ? AppColors.primaryColor : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHelpSection(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade700,
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              'Make sure your phone can receive SMS messages and check your spam folder.',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.blue.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}