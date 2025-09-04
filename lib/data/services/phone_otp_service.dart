import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneOTPService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _verificationIdKey = 'phone_verification_id';
  static const String _phoneNumberKey = 'phone_number';
  static const String _timestampKey = 'phone_otp_timestamp';
  static const int otpValidityMinutes = 5;

  // Send OTP to phone number using Firebase
  static Future<bool> sendPhoneOTP({
    required String phoneNumber,
    required BuildContext context,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    try {
      // Ensure phone number is in proper format (+91XXXXXXXXXX)
      String formattedPhone = _formatPhoneNumber(phoneNumber);

      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (happens on some Android devices)
          print('Auto-verification completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone verification failed: ${e.message}');
          onError(e.message ?? 'Phone verification failed');
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('OTP sent to $formattedPhone');

          // Store verification ID and phone number
          await _storeVerificationData(verificationId, formattedPhone);

          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Code auto retrieval timeout');
        },
        timeout: const Duration(seconds: 60),
      );

      return true;
    } catch (e) {
      print('Error sending phone OTP: $e');
      onError('Failed to send OTP. Please try again.');
      return false;
    }
  }

  // Send OTP to phone number using Firebase with immediate navigation
  static Future<bool> sendPhoneOTPFast({
    required String phoneNumber,
    required BuildContext context,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    try {
      // Ensure phone number is in proper format (+91XXXXXXXXXX)
      String formattedPhone = _formatPhoneNumber(phoneNumber);
      
      // Store phone number immediately for instant navigation
      await _storePhoneNumber(formattedPhone);

      // Start Firebase verification in background (don't await)
      _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('Auto-verification completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone verification failed: ${e.message}');
          onError(e.message ?? 'Phone verification failed');
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('OTP sent to $formattedPhone');
          
          // Store verification ID when Firebase responds
          await _storeVerificationData(verificationId, formattedPhone);
          
          // Call success callback with verification ID
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Code auto retrieval timeout');
          // Store verification ID even on timeout
          _storeVerificationData(verificationId, formattedPhone);
        },
        timeout: const Duration(seconds: 60),
      );

      // Return immediately for fast navigation
      return true;
    } catch (e) {
      print('Error sending phone OTP: $e');
      onError('Failed to send OTP. Please try again.');
      return false;
    }
  }

  // Verify phone OTP
  static Future<bool> verifyPhoneOTP(String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final verificationId = prefs.getString(_verificationIdKey);
      final timestamp = prefs.getInt(_timestampKey);

      if (verificationId == null || timestamp == null) {
        return false;
      }

      // Check if OTP has expired
      final now = DateTime.now().millisecondsSinceEpoch;
      final otpAge = Duration(milliseconds: now - timestamp);

      if (otpAge.inMinutes > otpValidityMinutes) {
        await _clearStoredData();
        return false;
      }

      // For phone OTP, we just validate that we have the verification ID and it's not expired
      // The actual verification happens during sign-up with the credential
      return true;
    } catch (e) {
      print('Error verifying phone OTP: $e');
      return false;
    }
  }

  // Get stored verification ID for later use in account creation
  static Future<String?> getStoredVerificationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_verificationIdKey);
  }

  // Get stored phone number
  static Future<String?> getStoredPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey);
  }

  // Create phone credential for account creation
  static PhoneAuthCredential createPhoneCredential(
      String verificationId, String otp) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
  }

  // Format phone number to include country code
  static String _formatPhoneNumber(String phoneNumber) {
    // Remove any spaces, dashes, or other formatting
    String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Add +91 for India if not present
    if (!cleanPhone.startsWith('91') && cleanPhone.length == 10) {
      cleanPhone = '91$cleanPhone';
    }

    if (!cleanPhone.startsWith('+')) {
      cleanPhone = '+$cleanPhone';
    }

    return cleanPhone;
  }

  // Store verification data
  static Future<void> _storeVerificationData(
      String verificationId, String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_verificationIdKey, verificationId);
    await prefs.setString(_phoneNumberKey, phoneNumber);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Store phone number separately for immediate use
  static Future<void> _storePhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phoneNumber);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Clear stored verification data
  static Future<void> _clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_verificationIdKey);
    await prefs.remove(_phoneNumberKey);
    await prefs.remove(_timestampKey);
  }

  // Check remaining time for resend functionality
  static Future<int> getRemainingTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_timestampKey);

      if (timestamp == null) {
        return 0;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsed = Duration(milliseconds: now - timestamp);
      final remaining = Duration(minutes: otpValidityMinutes) - elapsed;

      return remaining.inSeconds > 0 ? remaining.inSeconds : 0;
    } catch (e) {
      return 0;
    }
  }
}
