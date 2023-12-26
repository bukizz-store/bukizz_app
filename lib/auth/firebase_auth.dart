import 'package:bukizz_1/auth/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/Home_Screen2.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password , BuildContext context) async {
    try {
      UserDetails userDetails = UserDetails(
        name: '',
        className: '',
        section: '',
        email: email,
        password: password,
        uniqueId: '',
        uniqueIDPassword: '',
        schoolCode: '',
        address: '',
      );
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // print("Shivam :  $authResult" );

      if(authResult != null)
        {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => HomeScreen()), (route) => false);
        }
      else{
        const snackBar = SnackBar(
          content: Text("Failed to Login"),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // // Push user data to Firebase
      await userDetails.pushToFirebase();

      await userDetails.saveToSharedPreferences();

      notifyListeners();
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
