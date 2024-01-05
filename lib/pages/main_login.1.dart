import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/firebase_auth.dart';
import '../ui/screens/HomeView/homeScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  Future<void> signIn() async {
    //  sign-in logic here

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

  }

  Future<void> signInWithGoogle() async {
    //  sign-in with google logic here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

  }



  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,



        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),

                // Email text field
                TextField(
                  controller: _emailTextController,
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
                    icon: Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Password text field
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter Password",
                    icon: Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 10,
                ),


                // Sign In button
                ElevatedButton(
                  onPressed: () async{
                    String email = _emailTextController.text.trim();
                    String password = _passwordTextController.text.trim();
                    await authProvider.signInWithEmailAndPassword(email, password , context);
                  },
                  child: Text("Sign In"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: (){
                    signInWithGoogle();
                  },
                  child: Text("Sign In With Google"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
