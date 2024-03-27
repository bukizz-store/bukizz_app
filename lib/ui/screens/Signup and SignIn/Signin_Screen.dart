import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/reset_password.dart';
import 'package:bukizz/widgets/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../data/providers/auth/firebase_auth.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/buttons/Reusable_Button.dart';
import '../../../widgets/containers/Reusable_container.dart';
import '../../../widgets/text and textforms/Reusable_TextForm.dart';
import '../../../widgets/signup_text_widget.dart';
import '../../../widgets/text and textforms/Reusable_text.dart';
import '../../../widgets/text and textforms/newLoginTextForm.dart';
import '../HomeView/Ecommerce/main_screen.dart';
import 'Signup_Screen.dart';

class SignIn extends StatefulWidget {
  static const route = '/signInRoute';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    //dimension construction
    Dimensions dimensions = Dimensions(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text('Sign In'),
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

                //Email text
                // ReusableText(
                //   text: 'Email',
                //   fontSize: 14,
                //   height: 0.10,
                //   color: Color(0xFF121212),
                //   fontWeight: FontWeight.w500,
                // ),
                SizedBox(
                  height: dimensions.height10,
                ),
                // //Email Form
                // ReusableTextField('Your Email', Icons.person_outline, false,
                //     _emailTextController),

                CustomLoginForm(width: 90.sp, height: 30.sp, controller: _emailTextController, hintText: 'Your Email', labelText: 'Email', isPasswordType: false, type: InputType.email,icon: Icons.email_outlined,),

                SizedBox(
                  height: dimensions.height16,
                ),

                //password text
                // ReusableText(
                //   text: 'Password',
                //   fontSize: 14,
                //   height: 0.10,
                //   color: Color(0xFF121212),
                //   fontWeight: FontWeight.w500,
                // ),

                SizedBox(
                  height: dimensions.height10,
                ),
                //password form
                // ReusableTextField('Your Password', Icons.lock_outline, true,
                //     _passwordTextController),

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
                //login button
                ReusableElevatedButton(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () async {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailTextController.text)) {
                      AppConstants.showSnackBar(context, "Enter a valid Email",
                          AppColors.error, Icons.error_outline_rounded);
                      return;
                    }
                    AppConstants.buildShowDialog(context);
                    String email = _emailTextController.text.trim();
                    String password = _passwordTextController.text.trim();
                    await authProvider.signInWithEmailAndPassword(
                        email, password, context);
                  },
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
                  height: dimensions.height36,
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
                  height: dimensions.height36,
                ),

                //Sign in with google
                ReusableElevatedButton(
                  shadowColor: Colors.grey.withOpacity(0.6),
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () {
                    authProvider.googleSignInMethod(context);
                  },
                  buttonText: 'Sign in with Google',
                  buttonColor: Colors.white,
                  textColor: Color(0xFF121212),
                  fontSize: 14,
                  fontFamily: FontFamily.nunito.name,
                  fontWeight: FontWeight.w400,
                  imagePath: 'assets/google.png',
                  borderColor: Colors.black38,
                ),
                SizedBox(
                  height: dimensions.height8 * 2,
                ),
                ReusableElevatedButton(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  onPressed: () {},
                  buttonText: 'Sign in with Apple',
                  buttonColor: Colors.white,
                  iconData: Icons.apple,
                  textColor: Color(0xFF121212),
                  fontSize: 14,
                  fontFamily: FontFamily.nunito.name,
                  fontWeight: FontWeight.w400,
                  borderColor: Colors.black38,
                  shadowColor: Colors.grey.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//avbqdal;aslmkn
