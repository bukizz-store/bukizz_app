import 'package:bukizz_frontend/constants/font_family.dart';
import 'package:bukizz_frontend/utils/dimensions.dart';
import 'package:bukizz_frontend/widgets/Reusable_Button.dart';
import 'package:bukizz_frontend/widgets/Reusable_TextForm.dart';
import 'package:flutter/material.dart';
import '../widgets/reusable_text.dart';
import '../widgets/reusable_container.dart';
import '../widgets/signup_text_widget.dart';

class SignUp extends StatefulWidget {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //handle on press
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(

            padding:  EdgeInsets.fromLTRB(
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
                    return   ReusableText(
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
                    return   ReusableText(
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
                ReusableText(text: 'Name', fontSize: 14, height: 0.10,color: Color(0xFF121212),fontFamily:FontFamily.roboto,fontWeight: FontWeight.w500,),
                SizedBox(height: dimensions.height10,),
                //Name form
                //todo change  the icon maybe
                ReusableTextField('Your Name', Icons.person_outline, false, _nameTextController),

                SizedBox(height: dimensions.height16,),

                //Email text
                ReusableText(text: 'Email', fontSize: 14, height: 0.10,color: Color(0xFF121212),fontFamily:FontFamily.roboto,fontWeight: FontWeight.w500,),
                SizedBox(height: dimensions.height10,),
                //Email Form
                ReusableTextField('Your Email', Icons.person_outline, false, _emailTextController),


                SizedBox(height: dimensions.height16,),

                //password text
                ReusableText(text: 'Password', fontSize: 14, height: 0.10,color: Color(0xFF121212),fontFamily:FontFamily.roboto,fontWeight: FontWeight.w500,),

                SizedBox(height: dimensions.height10,),
                //password form
                ReusableTextField('Your Password', Icons.lock_outline, true, _passwordTextController),




                SizedBox(height: dimensions.height24,),

                //Register button
                ReusableElevatedButton(width: dimensions.width327, height: dimensions.height48, onPressed: (){}, buttonText: 'Register',fontFamily: FontFamily.roboto.name,fontSize:16,fontWeight: FontWeight.w700,),

                SizedBox(height: dimensions.height24,),

                signUpOption('Have an account?','Sign In'),



                SizedBox(height: dimensions.height138,),

                termsAndService('By clicking Register, you agree to our','Terms, Data Policy.'),
              ],
            ),


          ),
        ),
      ),
    );
  }
}
