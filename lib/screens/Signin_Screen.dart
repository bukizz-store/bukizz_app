import 'package:bukizz_frontend/widgets/Reusable_TextForm.dart';
import 'package:flutter/material.dart';
import '../widgets/reusable_text.dart';
import '../widgets/reusable_container.dart';

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
                    return const ReusableText(
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
                    return const ReusableText(
                      text: 'Sign to your account',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w400,
                      //todo add font family
                    );
                  },
                ),

                const SizedBox(
                  //Todo change width according to screen ratio
                  width: 50,
                ),
                // ReusableContainer(
                //   width: 327,
                //   height: 20,
                //   child: () {
                //     return const ReusableText(
                //       text: 'Email',
                //       fontSize: 16,
                //       height: 0.10,
                //       fontWeight: FontWeight.w500,
                //       //todo add font family
                //     );
                //   },
                // ),
                ReusableTextField('Your Email', Icons.person_outline, false, _emailTextController),

                SizedBox(
                  //todo adjust the width accordingly
                  width: 70,
                ),

                ReusableTextField('Your Password', Icons.lock_outline, true, _passwordTextController),

                SizedBox(

                    child: ReusableText(text: 'Forgot Password', fontSize: 14, height: 0.1,color: Color(0xFF03045E),fontWeight: FontWeight.w600,)
                )

              ],
            ),


          ),
        ),
      ),
    );
  }
}
