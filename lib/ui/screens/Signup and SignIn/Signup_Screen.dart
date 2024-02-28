import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/font_family.dart';
import '../../../data/providers/auth/firebase_auth.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/buttons/Reusable_Button.dart';
import '../../../widgets/containers/Reusable_container.dart';
import '../../../widgets/text and textforms/Reusable_TextForm.dart';
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
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //dimension construction
    Dimensions dimensions = Dimensions(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5FAFF),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimensions.width24,
              dimensions.height16,
              dimensions.width24,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //welcome text //done
                ReusableContainer(
                  width: dimensions.width327,
                  height: dimensions.height32,
                  child: () {
                    return ReusableText(
                      text: 'Sign Up',
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
                      text: 'Create account and choose favorite menu',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA6A6A6),

                    );
                  },
                ),

                //name text
                ReusableText(
                  text: 'Name',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: dimensions.height10,
                ),
                //Name form
                //todo change  the icon maybe
                ReusableTextField('Your Name', Icons.person_outline, false,
                    _nameTextController),

                SizedBox(
                  height: dimensions.height16,
                ),

                //Email text
                ReusableText(
                  text: 'Email',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: dimensions.height10,
                ),
                //Email Form
                ReusableTextField('Your Email', Icons.person_outline, false,
                    _emailTextController , ),

                SizedBox(
                  height: dimensions.height16,
                ),

                //password text
                ReusableText(
                  text: 'Password',
                  fontSize: 14,
                  height: 0.10,
                  color:  Color(0xFF121212),
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(
                  height: dimensions.height10,
                ),
                //password form
                ReusableTextField('Your Password', Icons.lock_outline, true,
                    _passwordTextController),

                SizedBox(
                  height: dimensions.height24,
                ),

                //Register button
                ReusableElevatedButton(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () async {
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailTextController.text))
                    {
                      AppConstants.showSnackBar(context, "Enter a valid Email", Colors.red, Icons.error_outline_rounded);
                      return;
                    }
                    AppConstants.buildShowDialog(context);
                    String email = _emailTextController.text.trim();
                    String password = _passwordTextController.text.trim();
                    String name = _nameTextController.text.trim();
                    await authProvider.signUpWithEmailAndPassword(name : name, email: email, password : password , context: context);
                  },
                  buttonText: 'Register',
                  fontFamily: FontFamily.nunito.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

                SizedBox(
                  height: dimensions.height24,
                ),

                signUpOption(
                    'Have an account?', 'Sign In', context, SignIn.route,
                ),

                SizedBox(
                  height: dimensions.height138,
                ),

                termsAndService('By clicking Register, you agree to our',
                    'Terms, Data Policy.',
                    (){
                      showCustomAboutDialog(context);
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void showCustomAboutDialog(BuildContext context) {
  Dimensions dimensions=Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  text: 'Privacy Policy',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF121212),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close_sharp)
                )
              ],
            ),
            ReusableText(text: 'Last Updated: 10/02/2024', fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFFA5A5A5),),
          ],
        ),
        content: Container(
          width: dimensions.width10 * 34.5,
          height: dimensions.height10 * 40.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      customTextSpan('Welcome to Bukizz, the mobile application developed and managed by Bukizz. We are committed to protecting the privacy and security of our users\' data. This Privacy Policy outlines the types of information we collect, how we use it, and the measures we take to protect it.\n1. Information Collection\n'),
                      customTextSpan('Personal Information: We may collect personal information such as your name, email address, phone number, and payment information when you register for our app, make a purchase, or interact with our services.\nUsage Data: We collect information about how you use our app, including the features you use, the time spent on the app, and your location data.\nDevice Information: We collect information from your mobile device, including hardware model, operating system, unique device identifiers, and mobile network information.\n'),
                      customTextSpan('2. Use of Information\nThe information we collect is used to:\n'),
                      customTextSpan('Provide, maintain, and improve our services.\nProcess transactions and send related information, including confirmations and invoices.\nSend you technical notices, updates, security alerts, and support messages.\nRespond to your comments, questions, and requests for customer service.\nCommunicate with you about products, services, offers, promotions, and events.\n'),
                      customTextSpan('3. Sharing of Information\nWe do not share your personal information with third parties except:\n'),
                      customTextSpan('With your consent.\nFor legal reasons, including to meet any applicable law, regulation, legal process, or enforceable governmental request.\nTo detect, prevent, or otherwise address fraud, security, or technical issues.\n'),
                      customTextSpan('4. Data Security\nWe implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the internet or method of electronic storage is 100% secure.\n5. Your Rights\nYou have the right to access, update, delete, or change your personal information. You can do this directly through your account settings or by contacting us.\n6. Children\'s Privacy\nOur app does not knowingly collect or solicit any information from anyone under the age of 13. If we learn that we have collected personal information from a child under age 13 without parental consent, we will delete that information as quickly as possible.\n7. Changes to This Privacy Policy\nWe may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date at the top.\n8. Contact Us\nIf you have any questions about this Privacy Policy, please contact us at [bukizzstore@gmail.com].'),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      );

    },
  );
}
//

TextSpan customTextSpan(String text) {
  return TextSpan(
    text: text,
    style: const TextStyle(
      color: Color(0xFF282828),
      fontSize: 12,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w400,
      height: 1.5, // Adjust the height as needed
    ),
  );
}