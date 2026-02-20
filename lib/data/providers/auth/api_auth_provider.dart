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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiAuthProvider extends ChangeNotifier {
  final AuthApiService _authService = AuthApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

      AppConstants.userData = userDetails;
      AppConstants.isLogin = true;

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
        AppConstants.showSnackBar(
            context, e.toString(), AppColors.error, Icons.error_outline_rounded);
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
        AppConstants.showSnackBar(
            context, e.toString().replaceAll('Exception: ', ''), AppColors.error, Icons.error_outline_rounded);
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
    _setLoading(true);
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
        AppConstants.showSnackBar(
            context, e.toString().replaceAll('Exception: ', ''), AppColors.error, Icons.error_outline_rounded);
      }
      try {
        await GoogleSignIn().signOut();
      } catch (e) {
        print("Error signing out from Google: $e");
      }
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
