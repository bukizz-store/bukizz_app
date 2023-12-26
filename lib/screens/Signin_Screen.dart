import 'package:bukizz_frontend/widgets/Reusable_Button.dart';
import 'package:bukizz_frontend/widgets/Reusable_TextForm.dart';
import 'package:flutter/material.dart';
import '../widgets/reusable_text.dart';
import '../widgets/reusable_container.dart';
import '../widgets/signup_text_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sign In'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(

            //todo  set padding according to screen ratio
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              24,
              0,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //welcome text
                ReusableContainer(
                  width: 327,
                  height: 32,
                  child: () {
                    return   ReusableText(
                      text: 'Welcome Back 👋',
                      fontSize: 24,
                      height: 0.06,
                    );
                  },
                ),

                //sign to your account text
                ReusableContainer(
                  width: 327,
                  height: 24,
                  child: () {
                    return   ReusableText(
                      text: 'Sign to your account',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w400,
                      //todo add font family
                    );
                  },
                ),


                //Email text
                ReusableText(text: 'Email', fontSize: 14, height: 0.10),
                SizedBox(height: 10,),
                //Email Form
                ReusableTextField('Your Email', Icons.person_outline, false, _emailTextController),


                SizedBox(height: 16,),

                //password text
                ReusableText(text: 'Password', fontSize: 14, height: 0.10),

                SizedBox(height: 10,),
                //password form
                ReusableTextField('Your Password', Icons.lock_outline, true, _passwordTextController),

                SizedBox(height: 10,),
                //forgot password
                InkWell(
                  onTap: () {
                    // Handle tap
                    print('Forgot Password tapped');
                  },
                  child: Container(

                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.10,
                        color: Color(0xFF03045E),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 24,),

                //login button
                ReusableElevatedButton(width: 327, height: 48, onPressed: (){}, buttonText: 'Login'),

                SizedBox(height: 24,),

                signUpOption(),

                SizedBox(height: 36,),

                //seperation lines with or with
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xFFE8E8E8),  //color of line
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ReusableText(
                              text: 'Or with',
                              fontSize: 14,
                              height: 0.10,
                              color: Color(0xFFA5A5A5),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE8E8E8),  // color of the line
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36,),
                //Sign in with google
                ReusableElevatedButton(width: 327, height: 48, onPressed: (){}, buttonText: 'Sign in with Google',buttonColor:Color(0xFFE8E8E8),),
                SizedBox(height: 8,),
                ReusableElevatedButton(width: 327, height: 48, onPressed: (){}, buttonText: 'Sign in with Apple',buttonColor:Color(0xFFE8E8E8),iconData: Icons.apple,),


              ],
            ),


          ),
        ),
      ),
    );
  }
}
