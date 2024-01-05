import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/firebase_auth.dart';
import '../../../constants/font_family.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //handle on press
            Navigator.of(context)
                .pushNamedAndRemoveUntil(SignIn.route, (route) => false);
          },
        ),
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
                      fontFamily: FontFamily.roboto,

                      //done
                      //todo add font family
                    );
                  },
                ),

                //name text
                ReusableText(
                  text: 'Name',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontFamily: FontFamily.roboto,
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
                  fontFamily: FontFamily.roboto,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: dimensions.height10,
                ),
                //Email Form
                ReusableTextField('Your Email', Icons.person_outline, false,
                    _emailTextController),

                SizedBox(
                  height: dimensions.height16,
                ),

                //password text
                ReusableText(
                  text: 'Password',
                  fontSize: 14,
                  height: 0.10,
                  color: Color(0xFF121212),
                  fontFamily: FontFamily.roboto,
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
                  onPressed: () async{
                    String email = _emailTextController.text.trim();
                    String password = _passwordTextController.text.trim();
                    String name = _nameTextController.text.trim();
                    await authProvider.signUpWithEmailAndPassword(name : name, email: email, password : password , context: context);
                  },
                  buttonText: 'Register',
                  fontFamily: FontFamily.roboto.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

                SizedBox(
                  height: dimensions.height24,
                ),

                signUpOption(
                    'Have an account?', 'Sign In', context, SignIn.route),

                SizedBox(
                  height: dimensions.height138,
                ),

                termsAndService('By clicking Register, you agree to our',
                    'Terms, Data Policy.',(){}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
