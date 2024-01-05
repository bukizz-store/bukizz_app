import 'package:bukizz_1/constants/colors.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../constants/font_family.dart';
import '../../../widgets/buttons/Reusable_Button.dart';
import '../../../widgets/keyboard/onScreenKeyboard.dart';
import '../../../widgets/signup_text_widget.dart';





class OtpScreen extends StatefulWidget {
  static const route = '/otpRoute';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          dimensions.width24,
          dimensions.height16,
          dimensions.width24,
          0,
        ),
        child: Column(
          children: [
            // Verification Email Text
            const SizedBox(
              width: 327,
              child: Text(
                'Verification Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 24,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  height: 0.06,
                  letterSpacing: -0.72,
                ),
              ),
            ),
            SizedBox(height: dimensions.height8 * 4),

            // Please enter the code text
            const SizedBox(
              width: 327,
              child: Text(
                'Please enter the code we just sent to email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                  fontSize: 16,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.09,
                  letterSpacing: -0.72,
                ),
              ),
            ),
            SizedBox(height: dimensions.height8 * 2),

            // Hardcoded email
            const SizedBox(
              width: 327,
              child: Text(
                'Johndoe@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 16,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.09,
                  letterSpacing: -0.72,
                ),
              ),
            ),
            SizedBox(height: dimensions.height32),

            // OTP Text Field
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 45,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle:  FieldStyle.box,
              onChanged: (pin) {
                // Handle the OTP value here
                print("Entered OTP: $pin");
              },
              onCompleted: (pin) {
                // Called when all the OTP digits are filled
                print("Completed OTP: $pin");
              },
            ),
            SizedBox(height: dimensions.height24),

            termsAndService('If you didn’t receive a code? ','Resend',(){}),
            SizedBox(height: dimensions.height48),

            ReusableElevatedButton(
              width: dimensions.width327,
              height: dimensions.height48,
              onPressed: () async{

              },
              buttonText: 'Continue',
              fontFamily: FontFamily.roboto.name,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: dimensions.height24),



          ],
        ),
      ),
    );
  }
}
