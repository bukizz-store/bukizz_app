import 'package:bukizz/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = '/resetpassword';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  ReusableText(
          text: "Reset Password",
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child:  SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableTextField('Enter Your Email', Icons.person, false, _emailTextController),
                    SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Reset Password", () async{
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailTextController.text.trim())
                          .then((value) => Navigator.of(context).pop());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Reset Link Sent to Your Registered Email Address'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }

                  )
                  ],
                ),
              ))),
    );
  }
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Color(0xFF058FFF);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: ReusableText(
        text: title,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
  );
}