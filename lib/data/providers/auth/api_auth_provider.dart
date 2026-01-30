import 'package:bukizz/data/models/user_details.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/services/auth_api_service.dart';
import 'package:bukizz/ui/screens/HomeView/ecommerce/onboarding%20screen/manual_location.dart'; // SelectLocation
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // Optionally logout if token invalid
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
    await _authService.logout();
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
    
    // Clear SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
       Navigator.pushNamedAndRemoveUntil(
              context, SignIn.route, (route) => false);
    }
    notifyListeners();
  }
  
  // Method placeholder to match existing AuthProvider signature if needed
  Future<void> googleSignInMethod(BuildContext context) async {
      // Implement Google Sign In via API if supported
      AppConstants.showSnackBar(context, "Google Sign In not yet supported via API", AppColors.error, Icons.error);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
