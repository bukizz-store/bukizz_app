import 'package:bukizz/data/models/user_details.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _uniqueIdController = TextEditingController();
  final TextEditingController _schoolCodeController = TextEditingController();
  @override

  void schoolLogin(String uniqueId , String uniquePasswordId , String schoolCode) async
  {

    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('userDetails')
          .where('email', isEqualTo: AppConstants.userData.email)
          .get();
      print("Shivam");

      var tempData = querySnapshot.docs.first.data();

      if(tempData['uniqueId'] == uniqueId)
        {
          if(tempData['uniqueIDPassword'] == uniquePasswordId)
            {
              if(tempData['schoolCode'] == schoolCode)
                {
                  AppConstants.isLogin = true;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', true);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => HomeScreen()), (route) => false);
                }
            }
        }else{
        const snackBar = SnackBar(content: Text("This user does not exist !!"));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    catch(e)
    {

    }
  }

  Widget build(BuildContext context) {
    return  Scaffold(
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
                  controller: _uniqueIdController,
                  decoration: const InputDecoration(
                    labelText: "Enter Unique ID",
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
                  height: 30,
                ),

                TextField(
                  controller: _schoolCodeController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter School Code",
                    icon: Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 30,
                ),


                // Sign In button


                ElevatedButton(
                  onPressed: (){
                     // school login using unique id
                    schoolLogin(_uniqueIdController.text , _passwordTextController.text , _schoolCodeController.text);
                  },
                  child: Text("Sign In With School"),
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
