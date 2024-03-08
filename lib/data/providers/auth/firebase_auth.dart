import 'dart:convert';
import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/models/user_details.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ui/screens/Signup and SignIn/Signin_Screen.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      print("hash Password ${MainUserDetails.hashPassword(password)}");
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("uid ${authResult.user!.uid}");

      MainUserDetails userDetails = MainUserDetails(
        name: '',
        email: email,
        password: MainUserDetails.hashPassword(password),
        uid: authResult.user!.uid,
        dob: DateTime.now().toIso8601String(),
        mobile: '',
        studentsUID: [],
        orderID: [],
        address: Address(
          houseNo: '',
          city: '',
          state: '',
          pinCode: '',
          street: '',
          phone: '',
          email: '',
          name: '',
        ),
        alternateAddress: Address(
          houseNo: '',
          city: '',
          state: '',
          pinCode: '',
          street: '',
          phone: '',
          email: '',
          name: '',
        ),
      );

      if (authResult.user!.uid.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('userDetails')
                .where('email', isEqualTo: email)
                .get();

        userDetails = MainUserDetails.fromMap(querySnapshot.docs.first.data());

        AppConstants.userData = userDetails;
        AppConstants.isLogin = true;

        // print(userDetails);

        // // Push user data to Firebase
        await userDetails.pushToFirebase();

        await userDetails.saveToSharedPreferences();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, SelectLocation.route, (route) => false);
        }
      } else {
        if (context.mounted) {
          AppConstants.showSnackBar(
            context,
            "Failed to Login",
            AppColors.error,
            Icons.error_outline_rounded,
          );
          Navigator.of(context).pop();
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle sign-in errors
      String errorMessage = "An error occurred during sign-in.";

      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'user-not-found') {
          errorMessage = "No user found with this email.";
        } else if (e.code == 'invalid-credential') {
          errorMessage = "Incorrect password.";
        } else {
          errorMessage = "Error: ${e.message}";
        }
      }

      if (context.mounted) {
        AppConstants.showSnackBar(context, errorMessage, AppColors.error,
            Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
      print("Error signing in: $e");
    }
  }

  Future<void> googleSignInMethod(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken);
      await googleSignUp(context, authCredential);
    } catch (e) {
      debugPrint(e.toString());
      AppConstants.showSnackBar(context, "Unable to Continue with Google",
          AppColors.error, Icons.error_outline_rounded);
    }
  }

  Future<void> googleSignUp(
      BuildContext context, AuthCredential authCredential) async {
    // Getting users credential
    try {
      AppConstants.buildShowDialog(context);
      await _auth.signInWithCredential(authCredential).then((value) async {
        if (value.user != null) {
          MainUserDetails userDetails = MainUserDetails(
            name: value.user!.displayName!,
            email: value.user!.email!,
            password: '',
            address: Address(
              houseNo: '',
              city: '',
              state: '',
              pinCode: '',
              street: '',
              phone: '',
              email: '',
              name: '',
            ),
            uid: value.user!.uid,
            dob: DateTime.now().toIso8601String(),
            mobile: value.user!.phoneNumber ?? '',
            alternateAddress: Address(
              houseNo: '',
              city: '',
              state: '',
              pinCode: '',
              street: '',
              phone: '',
              email: '',
              name: '',
            ),
            studentsUID: [],
            orderID: [],
          );

          if (_auth.currentUser != null) {
            // // Push user data to Firebase
            await userDetails.pushToFirebase();

            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                await FirebaseFirestore.instance
                    .collection('userDetails')
                    .where('email', isEqualTo: value.user!.email)
                    .get();

            userDetails =
                MainUserDetails.fromMap(querySnapshot.docs.first.data());

            AppConstants.userData = userDetails;
            await userDetails.saveToSharedPreferences();

            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, SelectLocation.route, (route) => false);
            }
          } else {
            if (context.mounted) {
              AppConstants.showSnackBar(
                  context,
                  "Error signing in with Google. Please try again later",
                  AppColors.error,
                  Icons.error_outline_rounded);
            }
          }
        }
      });
    } catch (e) {
      AppConstants.showSnackBar(
          context, e.toString(), AppColors.error, Icons.error_outline_rounded);
      GoogleSignIn().signOut();
    }

    // if result not null we simply call the MaterialpageRoute,
    // for go to the HomePage scree
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
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

      if (authResult.user != null && authResult.user!.uid.isNotEmpty) {
        Address address = Address(
          houseNo: '',
          city: '',
          state: '',
          pinCode: '',
          street: '',
          phone: authResult.user!.phoneNumber ?? "",
          email: email,
          name: name,
        );

        Address alternateAddress = Address(
          houseNo: '',
          city: '',
          state: '',
          pinCode: '',
          street: '',
          phone: '',
          email: '',
          name: '',
        );

        print(authResult.user!.uid);

        MainUserDetails userDetails = MainUserDetails(
          name: name,
          email: email,
          password: hashPassword(password),
          address: address,
          uid: authResult.user!.uid,
          dob: DateTime.now().toIso8601String(),
          mobile: authResult.user!.phoneNumber ?? "",
          alternateAddress: alternateAddress,
          studentsUID: [],
          orderID: [],
        );

        try {
          // Push user data to Firebase
          await userDetails.pushToFirebase();
          // Save user details to shared preferences
          await userDetails.saveToSharedPreferences();
        } catch (e) {
          print("Error due to $e");
        }

        AppConstants.isLogin=true;

        // Navigate to the home screen
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, SelectLocation.route, (route) => false);
        }

        notifyListeners();
      } else {
        AppConstants.showSnackBar(context, "Failed to SignUp", AppColors.error,
            Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
    } catch (e) {
      String errorMessage = "An error occurred during sign-up.";

      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'email-already-in-use') {
          errorMessage = "The email address is already in use.";
        } else {
          errorMessage = "Error: ${e.message}";
        }
      }

      if (context.mounted) {
        AppConstants.showSnackBar(context, errorMessage, AppColors.error,
            Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
    }
  }

  // sign in with apple
  Future<void> signInWithApple(BuildContext context) async {
    final appleProvider = AppleAuthProvider();
    final authResult =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);

    if (authResult.user!.uid.isNotEmpty) {
      Address address = Address(
        houseNo: '',
        city: '',
        state: '',
        pinCode: '',
        street: '',
        phone: authResult.user!.phoneNumber ?? "",
        email: 'apple@email.com',
        name: 'apple_user',
      );

      Address alternateAddress = Address(
        houseNo: '',
        city: '',
        state: '',
        pinCode: '',
        street: '',
        phone: '',
        email: '',
        name: '',
      );

      print(authResult.user!.uid);

      MainUserDetails userDetails = MainUserDetails(
        name: 'apple_user',
        email: 'apple@email.com',
        password: '',
        address: address,
        uid: authResult.user!.uid,
        dob: DateTime.now().toIso8601String(),
        mobile: authResult.user!.phoneNumber ?? "",
        alternateAddress: alternateAddress,
        studentsUID: [],
        orderID: [],
      );

      try {
        // Push user data to Firebase
        await userDetails.pushToFirebase();
        // Save user details to shared preferences
        await userDetails.saveToSharedPreferences();
      } catch (e) {
        print("Error due to $e");
      }

      AppConstants.isLogin=true;

      // Navigate to the home screen
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, SelectLocation.route, (route) => false);
      }

      notifyListeners();
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
      try {
        AppConstants.isLogin=false;
        user!
            .delete()
            .then((value) => FirebaseFirestore.instance
                .collection('deletedAccount')
                .add(AppConstants.userData.toMap())
                .then((value) => AppConstants.showSnackBarTop(
                    context,
                    "Account User Deleted!",
                    AppColors.green,
                    Icons.check_circle_outline_rounded))
                .catchError((e) => AppConstants.showSnackBarTop(
                    context,
                    e.toString(),
                    AppColors.error,
                    Icons.error_outline_rounded)))
            .catchError((e) => AppConstants.showSnackBarTop(context,
                e.toString(), AppColors.error, Icons.error_outline_rounded));
        signOut(context);
      } catch (e) {
        print(e.toString());
        // AppConstants.showSnackBarTop(context,
        //     e.toString(), AppColors.error, Icons.error_outline_rounded);
        return null;
      }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppConstants.userData = MainUserDetails(
      name: '',
      email: '',
      password: '',
      address: Address(
        houseNo: '',
        city: '',
        state: '',
        pinCode: '',
        street: '',
        phone: '',
        email: '',
        name: '',
      ),
      uid: '',
      dob: DateTime.now().toIso8601String(),
      mobile: '',
      alternateAddress: Address(
        houseNo: '',
        city: '',
        state: '',
        pinCode: '',
        street: '',
        phone: '',
        email: '',
        name: '',
      ),
      studentsUID: [],
      orderID: [],
    );
    await GoogleSignIn().signOut();
    AppConstants.isLogin=false;
    await _auth.signOut().then((value) => {
          Navigator.pushNamedAndRemoveUntil(
              context, SignIn.route, (route) => false)
        });
    notifyListeners();
  }
}
