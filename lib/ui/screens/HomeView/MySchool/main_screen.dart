import 'package:bukizz_1/data/providers/cart_provider.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../auth/firebase_auth.dart';
import '../../../../constants/constants.dart';
import '../../../../pages/student_teacher_login.3.dart';
import '../../Signup and SignIn/Signin_Screen.dart';

class MySchoolMain extends StatefulWidget {
  const MySchoolMain({super.key});

  @override
  State<MySchoolMain> createState() => _MySchoolMainState();
}

class _MySchoolMainState extends State<MySchoolMain> {

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Center(
      child: AppConstants.isLogin ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppConstants.userData.email),
          ElevatedButton(
            onPressed: () async{
              // Handle the teacher button click
              AppConstants.isLogin = true;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogin', true);
              authProvider.signOut(context);
              Navigator.pushNamedAndRemoveUntil(context, SignIn.route, (route) => false);
            },
            child: Text("Logout"),
          ),
        ],
      ) :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle the teacher button click
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StudentLogin()),
              context.read<CartViewRepository>().cartData = {};
              context.read<CartProvider>().cartData ={};
              authProvider.signOut(context);
              Navigator.pushNamedAndRemoveUntil(context, SignIn.route, (route) => false);
              // );
            },
            child: Text("Teacher"),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Handle the student button click
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentLogin()),
              );
            },

            child: Text("Student"),
          ),
        ],
      ),
    );
  }
}
