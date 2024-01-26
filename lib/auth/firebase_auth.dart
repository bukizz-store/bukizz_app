import 'dart:convert';
import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/models/user_details.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/screens/Signup and SignIn/Signin_Screen.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password,
      BuildContext context) async {
    try {
      print(MainUserDetails.hashPassword(password));
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(authResult.user!.uid);


      MainUserDetails userDetails = MainUserDetails(
        name: '',
        email: email,
        password: MainUserDetails.hashPassword(password),
        address: '',
        uid: authResult.user!.uid,
        dob: DateTime.now().toIso8601String(),
        mobile: '',
        alternateAddress: '',
        studentsUID: [],
        orderID: [],
      );

      if (authResult != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('userDetails')
            .where('email', isEqualTo: email)
            .get();

        userDetails = MainUserDetails.fromMap(querySnapshot.docs.first.data());

        AppConstants.userData = userDetails;

        print(userDetails);

        // // Push user data to Firebase
        await userDetails.pushToFirebase(authResult);

        await userDetails.saveToSharedPreferences();

        Navigator.pushNamedAndRemoveUntil(
            context, LocationScreen.route, (route) => false);
      }
      else {
        const snackBar = SnackBar(
          content: Text("Failed to Login"),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      notifyListeners();
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  Future<void> googleSignUp(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      MainUserDetails userDetails = MainUserDetails(
        name: result.user!.displayName!,
        email: result.user!.email!,
        password: '',
        address: '',
        uid: result.user!.uid,
        dob: DateTime.now().toIso8601String(),
        mobile: result.user!.phoneNumber ?? '',
        alternateAddress: '',
        studentsUID: [],
        orderID: [],
      );

      if (result.user!.uid.isNotEmpty) {
        // // Push user data to Firebase
        await userDetails.pushToFirebase(result);

        QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
            .collection('userDetails')
            .where('email', isEqualTo: result.user!.email)
            .get();

        userDetails = MainUserDetails.fromMap(querySnapshot.docs.first.data());

        AppConstants.userData = userDetails;
        await userDetails.saveToSharedPreferences();

        Navigator.pushNamedAndRemoveUntil(
            context, LocationScreen.route, (route) => false);
      }
      else {
        const snackBar = SnackBar(
          content: Text("Failed to Login"),
        );
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage scree
      notifyListeners();
    }
  }


    Future<void> signUpWithEmailAndPassword({
      required String name,
      required String email,
      required String password,
      required BuildContext context,
    }) async {
      try {
        // Create a UserDetails instance

        // Hash the password using SHA-256
        String hashPassword(String password) {
          var bytes = utf8.encode(password);
          var digest = sha256.convert(bytes);
          return digest.toString();
        }

        // Create a Firebase user using email and password
        UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (authResult != null) {
          MainUserDetails userDetails = MainUserDetails(
            name: name,
            email: email,
            password: hashPassword(password),
            address: "",
            uid: authResult.user!.uid,
            dob: DateTime.now().toIso8601String(),
            mobile: "",
            alternateAddress: "",
            studentsUID: [],
            orderID: [],
          );
          // Get the user ID from the authentication result
          String userId = authResult.user!.uid;

          // // Push user data to Firebase
          await userDetails.pushToFirebase(authResult);

          // Save user details to shared preferences
          await userDetails.saveToSharedPreferences();

          // Navigate to the home screen
          Navigator.pushNamedAndRemoveUntil(
              context, LocationScreen.route, (route) => false);

          notifyListeners();
        }
        else {
          const snackBar = SnackBar(
            content: Text("Failed to SignUP"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print("Error signing up: $e");
        const snackBar = SnackBar(
          content: Text("Failed to Sign Up"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    Future<void> signOut(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      AppConstants.userData = MainUserDetails(
        name: '',
        email: '',
        password: '',
        address: '',
        uid: '',
        dob: DateTime.now().toIso8601String(),
        mobile: '',
        alternateAddress: '',
        studentsUID: [],
        orderID: [],
      );
      await _auth.signOut().then((value) =>
      {
        Navigator.pushNamedAndRemoveUntil(
            context, SignIn.route, (route) => false)
      });
      notifyListeners();
    }
  }
