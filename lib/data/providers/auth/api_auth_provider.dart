import 'package:bukizz/data/models/user_details.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/services/auth_api_service.dart';
import 'package:bukizz/ui/screens/HomeView/ecommerce/onboarding%20screen/manual_location.dart'; // SelectLocation
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:math' as dart_math;
import 'package:crypto/crypto.dart';

class ApiAuthProvider extends ChangeNotifier {
  final AuthApiService _authService = AuthApiService();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;

  bool get isLoading => _isLoading;
  bool get isGoogleLoading => _isGoogleLoading;
  bool get isAppleLoading => _isAppleLoading;

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      final response = await _authService.login(email, password);
      
      final data = response['data'];
      final user = data['user'];

      await _authService.storeTokens(data['accessToken'], data['refreshToken']);

      // Convert API user to MainUserDetails
      // Note: Adjust mapping based on actual API response structure and MainUserDetails model
      MainUserDetails userDetails = MainUserDetails(
        name: user['full_name'] ?? '',
        email: user['email'] ?? '',
        password: '',
        uid: user['id'] ?? '',
        dob: '',
        mobile: '',
        studentsUID: [],
        orderID: [],
        address: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: ''),
        alternateAddress: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: ''),
      );
      // The login is successful, save the essential user data required for session persistence
      AppConstants.userData = userDetails;
      AppConstants.isLogin = true;
      await userDetails.saveToSharedPreferences();

      // Save to SharedPreferences (MainUserDetails specific saving if needed, 
      // but strictly we rely on tokens for API auth. 
      // However, existing app structure relies on AppConstants.userData)
      // We might need to fetch full profile to populate this correctly.
      try {
         final profileData = await _authService.fetchProfile();
         final profileUser = profileData['data']['user'];
         
         // Update userDetails with more info
         userDetails.name = profileUser['fullName'] ?? userDetails.name;
         userDetails.mobile = profileUser['phone'] ?? userDetails.mobile;
         // ... map other fields
         
         AppConstants.userData = userDetails;
         await userDetails.saveToSharedPreferences();
      } catch (e) {
        print("Error fetching profile after login: $e");
      }

      if (context.mounted) {
        Navigator.of(context).pop(); // Dismiss loading dialog if any
        Navigator.pushNamedAndRemoveUntil(
            context, SelectLocation.route, (route) => false);
      }
    } catch (e) {
      print("ApiAuthProvider Login Error: $e");
      if (context.mounted) {
        Navigator.of(context).pop();
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        // Clean up common error prefixes
        if (errorMessage.contains("Failed to connect to server: ")) {
           errorMessage = errorMessage.replaceAll("Failed to connect to server: ", "");
        }
        if (errorMessage.contains("Your account is inactive") || errorMessage.contains("inactive")) {
           errorMessage = "This account does not exist.";
        }
        AppConstants.showSnackBar(
            context, errorMessage, AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String name, String email, String password, String phone, BuildContext context) async {
    _setLoading(true);
    try {
      final response = await _authService.register(name, email, password, phone);
      
      final data = response['data'];
      final user = data['user'];

      await _authService.storeTokens(data['accessToken'], data['refreshToken']);

      // Create User Details
      MainUserDetails userDetails = MainUserDetails(
        name: user['full_name'] ?? name,
        email: user['email'] ?? email,
        password: '',
        uid: user['id'] ?? '',
        dob: '',
        mobile: user['phone'] ?? phone,
        studentsUID: [],
        orderID: [],
        address: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: ''),
        alternateAddress: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: ''),
      );

      AppConstants.userData = userDetails;
      AppConstants.isLogin = true;
      await userDetails.saveToSharedPreferences();

      // Try to fetch full profile (optional, but good for consistency)
      try {
         final profileData = await _authService.fetchProfile();
         if(profileData['data'] != null && profileData['data']['user'] != null){
             final profileUser = profileData['data']['user'];
             userDetails.name = profileUser['fullName'] ?? userDetails.name;
             userDetails.mobile = profileUser['phone'] ?? userDetails.mobile;
             // Update ID if needed
             if(userDetails.uid.isEmpty) userDetails.uid = profileUser['id'] ?? '';
         }
         AppConstants.userData = userDetails;
         await userDetails.saveToSharedPreferences();
      } catch (e) {
        print("Error fetching profile after signup: $e");
      }

      if (context.mounted) {
        Navigator.of(context).pop(); // Dismiss loading dialog if any
        AppConstants.showSnackBar(
            context, "Registration Successful", AppColors.green, Icons.check_circle_outline);
        // Navigate to Location Selection or Home
        Navigator.pushNamedAndRemoveUntil(
            context, SelectLocation.route, (route) => false);
      }
    } catch (e) {
      print("ApiAuthProvider SignUp Error: $e");
      if (context.mounted) {
        // Navigator.of(context).pop(); // Only if a dialog was shown
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        if (errorMessage.contains("Failed to connect to server: ")) {
           errorMessage = errorMessage.replaceAll("Failed to connect to server: ", "");
        }
        if (errorMessage.contains("Your account is inactive") || errorMessage.contains("inactive")) {
           errorMessage = "This account does not exist.";
        }
        AppConstants.showSnackBar(
            context, errorMessage, AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    _setLoading(true);
    try {
      final response = await _authService.forgotPassword(email);
      // The API returns success even if email doesn't exist (security practice)
      if (context.mounted) {
        AppConstants.showSnackBar(
            context,
            response['message'] ?? 'If the email exists, a reset link has been sent',
            AppColors.green,
            Icons.check_circle_outline);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print("ApiAuthProvider ForgotPassword Error: $e");
      if (context.mounted) {
        AppConstants.showSnackBar(
            context, e.toString().replaceAll('Exception: ', ''), AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadUserFromToken() async {
    try {
      final token = await _authService.getAccessToken();
      if (token != null) {
         final profileData = await _authService.fetchProfile();
         final profileUser = profileData['data']['user'];
         
         MainUserDetails userDetails = MainUserDetails(
            name: profileUser['fullName'] ?? '',
            email: profileUser['email'] ?? '',
            password: '',
            uid: '', // API might not return UID in profile?
            dob: '',
            mobile: profileUser['phone'] ?? '',
            studentsUID: [],
            orderID: [],
            address: Address(
                name: '',
                phone: '',
                houseNo: '',
                street: '',
                city: '',
                state: '',
                pinCode: '',
                email: ''),
            alternateAddress: Address(
                name: '',
                phone: '',
                houseNo: '',
                street: '',
                city: '',
                state: '',
                pinCode: '',
                email: ''),
         );
         
         AppConstants.userData = userDetails;
         AppConstants.isLogin = true;
         notifyListeners();
      }
    } catch (e) {
      print("Failed to load user from token: $e");
      // Token is invalid, clear login state
      AppConstants.isLogin = false;
      await _authService.logout();
      notifyListeners();
    }
  }

  // Placeholder for Phone Login
  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    // API Implementation for Phone Verification would go here
    print("Phone Login not supported via API yet");
    AppConstants.showSnackBar(
        context, "Phone Login not supported via API yet", AppColors.error, Icons.error);
  }

  Future<void> deleteAccount(BuildContext context) async {
    _setLoading(true);
    try {
      await _authService.deleteAccount();

      // Clear all local state
      AppConstants.isLogin = false;
      AppConstants.userData = MainUserDetails(
        name: '', email: '', password: '', uid: '', dob: '', mobile: '',
        studentsUID: [], orderID: [],
        address: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
        alternateAddress: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (context.mounted) {
        Navigator.pop(context); // Dismiss confirmation dialog
        AppConstants.showSnackBar(
            context, "Account deleted successfully", AppColors.green, Icons.check_circle_outline);
        Navigator.pushNamedAndRemoveUntil(
            context, SignIn.route, (route) => false);
      }
    } catch (e) {
      print("ApiAuthProvider DeleteAccount Error: $e");
      if (context.mounted) {
        Navigator.pop(context); // Dismiss confirmation dialog
        AppConstants.showSnackBar(
            context, e.toString().replaceAll('Exception: ', ''), AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    // 1. Clear Backend Session
    await _authService.logout();
    
    // 2. Clear Google Session
    try {
      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().signOut();
        await GoogleSignIn().disconnect();
      }
    } catch (e) {
      print("Error signing out from Google: $e");
    }

    // 3. Clear Supabase Session
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      print("Error signing out from Supabase: $e");
    }

    // 4. Clear Global State
    AppConstants.isLogin = false;
    AppConstants.userData = MainUserDetails(
      name: '', email: '', password: '', uid: '', dob: '', mobile: '', 
      studentsUID: [], orderID: [], 
      address: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: ''),
      alternateAddress: Address(
            name: '',
            phone: '',
            houseNo: '',
            street: '',
            city: '',
            state: '',
            pinCode: '',
            email: '')
    );
    
    // 5. Clear SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
       Navigator.pushNamedAndRemoveUntil(
              context, SignIn.route, (route) => false);
    }
    notifyListeners();
  }
  
  // Google Sign In (Native Flow)
  Future<void> googleSignInMethod(BuildContext context) async {
    _setGoogleLoading(true);
    try {
      /// Web Client ID from env (Google Cloud Console)
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']!;

      /// iOS Client ID from env (Google Cloud Console)
      final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID']!;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        _setLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('No ID Token found from Google Sign-In');
      }

      // Authenticate with Supabase
      final AuthResponse response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final Session? session = response.session;
      if (session == null) {
         throw Exception('Supabase Sign-In failed: No session created');
      }

      final String supabaseToken = session.accessToken;

      // Verify with Backend
      final backendResponse = await _authService.googleLogin(supabaseToken);
      
      final data = backendResponse['data'];
      final user = data['user'];

      //Store tokens from Backend
      await _authService.storeTokens(data['accessToken'], data['refreshToken']);

      // Create User Details
      MainUserDetails userDetails = MainUserDetails(
        name: user['full_name'] ?? googleUser.displayName ?? '',
        email: user['email'] ?? googleUser.email,
        password: '',
        uid: user['id'] ?? '',
        dob: '',
        mobile: user['phone'] ?? '',
        studentsUID: [],
        orderID: [],
        address: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
        alternateAddress: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
      );

      AppConstants.userData = userDetails;
      AppConstants.isLogin = true;
      await userDetails.saveToSharedPreferences();

      // Try fetching profile
      try {
         final profileData = await _authService.fetchProfile();
         if(profileData['data'] != null && profileData['data']['user'] != null){
             final profileUser = profileData['data']['user'];
             userDetails.name = profileUser['fullName'] ?? userDetails.name;
             userDetails.mobile = profileUser['phone'] ?? userDetails.mobile;
             if(userDetails.uid.isEmpty) userDetails.uid = profileUser['id'] ?? '';
         }
         AppConstants.userData = userDetails;
         await userDetails.saveToSharedPreferences();
      } catch (e) {
        print("Error fetching profile after google login: $e");
      }

      if (context.mounted) {
         Navigator.pushNamedAndRemoveUntil(
            context, SelectLocation.route, (route) => false);
      }

    } catch (e) {
      print("Google Sign-In Error: $e");
      if (context.mounted) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        if (errorMessage.contains("Failed to connect to server: ")) {
           errorMessage = errorMessage.replaceAll("Failed to connect to server: ", "");
        }
        if (errorMessage.contains("Your account is inactive") || errorMessage.contains("inactive")) {
           errorMessage = "This account does not exist.";
        }
        AppConstants.showSnackBar(
            context, errorMessage, AppColors.error, Icons.error_outline_rounded);
      }
      try {
        await GoogleSignIn().signOut();
      } catch (e) {
        print("Error signing out from Google: $e");
      }
    } finally {
      _setGoogleLoading(false);
    }
  }

  /// Generate a random string to be used as a nonce.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = dart_math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> appleSignInMethod(BuildContext context) async {
    _setAppleLoading(true);
    try {
      final rawNonce = _generateNonce();
      final hashedNonce = _sha256ofString(rawNonce);

      // Request Apple credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = appleCredential.identityToken;
      if (idToken == null) {
        throw Exception('No ID Token found from Apple Sign-In');
      }

      // Authenticate with Supabase using Apple ID token
      final AuthResponse response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      final Session? session = response.session;
      if (session == null) {
        throw Exception('Supabase Sign-In failed: No session created');
      }

      final String supabaseToken = session.accessToken;

      // Verify with Backend
      final backendResponse = await _authService.appleLogin(supabaseToken);

      final data = backendResponse['data'];
      final user = data['user'];

      // Store tokens from Backend
      await _authService.storeTokens(data['accessToken'], data['refreshToken']);

      // Build display name from Apple credential if available
      String displayName = '';
      if (appleCredential.givenName != null || appleCredential.familyName != null) {
        displayName = '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim();
      }

      // Create User Details
      MainUserDetails userDetails = MainUserDetails(
        name: user['full_name'] ?? displayName,
        email: user['email'] ?? appleCredential.email ?? '',
        password: '',
        uid: user['id'] ?? '',
        dob: '',
        mobile: user['phone'] ?? '',
        studentsUID: [],
        orderID: [],
        address: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
        alternateAddress: Address(
            name: '', phone: '', houseNo: '', street: '', city: '', state: '', pinCode: '', email: ''),
      );

      AppConstants.userData = userDetails;
      AppConstants.isLogin = true;
      await userDetails.saveToSharedPreferences();

      // Try fetching profile
      try {
        final profileData = await _authService.fetchProfile();
        if (profileData['data'] != null && profileData['data']['user'] != null) {
          final profileUser = profileData['data']['user'];
          userDetails.name = profileUser['fullName'] ?? userDetails.name;
          userDetails.mobile = profileUser['phone'] ?? userDetails.mobile;
          if (userDetails.uid.isEmpty) userDetails.uid = profileUser['id'] ?? '';
        }
        AppConstants.userData = userDetails;
        await userDetails.saveToSharedPreferences();
      } catch (e) {
        print("Error fetching profile after Apple login: $e");
      }

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, SelectLocation.route, (route) => false);
      }
    } catch (e) {
      print("Apple Sign-In Error: $e");
      if (context.mounted) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        if (errorMessage.contains("Failed to connect to server: ")) {
           errorMessage = errorMessage.replaceAll("Failed to connect to server: ", "");
        }
        if (errorMessage.contains("Your account is inactive") || errorMessage.contains("inactive")) {
           errorMessage = "This account does not exist.";
        }
        AppConstants.showSnackBar(
            context, errorMessage, AppColors.error, Icons.error_outline_rounded);
      }
    } finally {
      _setAppleLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setGoogleLoading(bool value) {
    _isGoogleLoading = value;
    notifyListeners();
  }

  void _setAppleLoading(bool value) {
    _isAppleLoading = value;
    notifyListeners();
  }
}
