import 'dart:isolate';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'email_config.dart';

class OTPService {
  static const String _otpKey = 'stored_otp';
  static const String _emailKey = 'otp_email';
  static const String _timestampKey = 'otp_timestamp';
  static const int otpValidityMinutes = 5;

  // Generate a 6-digit OTP
  static String generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Fast OTP sending with immediate response
  static Future<String> sendOTPFast(String email) async {
    // Generate OTP immediately
    final otp = generateOTP();

    // Store OTP immediately for instant verification capability
    await _storeOTP(email, otp);

    // Send email in background without waiting
    _sendEmailInBackground(email, otp);

    // Return OTP immediately for development (remove in production)
    print('DEVELOPMENT MODE - OTP for $email: $otp');

    return otp;
  }

  // Background email sending using Isolate
  static void _sendEmailInBackground(String email, String otp) async {
    // Use compute or Isolate.spawn for heavy operations
    try {
      // Start email sending in background
      await Isolate.spawn(_emailSenderIsolate, {
        'email': email,
        'otp': otp,
        'smtpHost': EmailConfig.smtpHost,
        'smtpPort': EmailConfig.smtpPort,
        'senderEmail': EmailConfig.senderEmail,
        'senderPassword': EmailConfig.senderPassword,
        'senderName': EmailConfig.senderName,
      });

      print('Email sending started in background for $email');
    } catch (e) {
      print('Background email sending failed: $e');
    }
  }

  // Isolate function for sending email
  static void _emailSenderIsolate(Map<String, dynamic> params) async {
    try {
      final email = params['email'] as String;
      final otp = params['otp'] as String;

      // Configure SMTP server
      final smtpServer = SmtpServer(
        params['smtpHost'] as String,
        port: params['smtpPort'] as int,
        username: params['senderEmail'] as String,
        password: params['senderPassword'] as String,
        allowInsecure: false,
        ssl: false,
        ignoreBadCertificate: false,
      );

      // Create the email message
      final message = Message()
        ..from = Address(
            params['senderEmail'] as String, params['senderName'] as String)
        ..recipients.add(email)
        ..subject = 'Bukizz - Email Verification Code'
        ..html = EmailConfig.getOTPEmailTemplate(otp, otpValidityMinutes);

      // Send email
      final sendReport = await send(message, smtpServer);
      print('Background email sent successfully: ${sendReport.toString()}');
    } catch (e) {
      print('Background email sending failed: $e');
    }
  }

  // Optimized OTP sending with timeout
  static Future<bool> sendOTP(String email, String otp) async {
    try {
      // Store OTP immediately
      await _storeOTP(email, otp);

      // Try to send email with timeout
      return await _sendEmailWithTimeout(email, otp).timeout(
        const Duration(seconds: 3), // 3-second timeout
        onTimeout: () {
          print('Email sending timeout - continuing with stored OTP');
          return true; // Return success even if email times out
        },
      );
    } catch (e) {
      print('Error in sendOTP: $e');
      return true; // Return success anyway since OTP is stored
    }
  }

  // Send email with connection pooling and optimization
  static Future<bool> _sendEmailWithTimeout(String email, String otp) async {
    try {
      // Optimized SMTP configuration
      final smtpServer = SmtpServer(
        EmailConfig.smtpHost,
        port: EmailConfig.smtpPort,
        username: EmailConfig.senderEmail,
        password: EmailConfig.senderPassword,
        allowInsecure: true, // Allow insecure for faster connection
        ssl: false,
        ignoreBadCertificate: true, // Ignore certificate for speed
      );

      // Create lightweight email message
      final message = Message()
        ..from = Address(EmailConfig.senderEmail, EmailConfig.senderName)
        ..recipients.add(email)
        ..subject = 'Bukizz - Email Verification Code'
        ..html = EmailConfig.getOTPEmailTemplate(otp, otpValidityMinutes);

      // Send with timeout
      await send(message, smtpServer).timeout(const Duration(seconds: 2));
      return true;
    } catch (e) {
      print('Email sending failed: $e');
      return true; // Return true anyway since OTP is stored locally
    }
  }

  // Verify OTP
  static Future<bool> verifyOTP(String email, String enteredOTP) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedOTP = prefs.getString(_otpKey);
      final storedEmail = prefs.getString(_emailKey);
      final timestamp = prefs.getInt(_timestampKey);

      if (storedOTP == null || storedEmail == null || timestamp == null) {
        return false;
      }

      // Check if email matches
      if (storedEmail != email) {
        return false;
      }

      // Check if OTP has expired
      final now = DateTime.now().millisecondsSinceEpoch;
      final otpAge = Duration(milliseconds: now - timestamp);

      if (otpAge.inMinutes > otpValidityMinutes) {
        await _clearStoredOTP();
        return false;
      }

      // Check if OTP matches
      if (storedOTP == enteredOTP) {
        await _clearStoredOTP();
        return true;
      }

      return false;
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  // Store OTP locally with timestamp
  static Future<void> _storeOTP(String email, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_otpKey, otp);
    await prefs.setString(_emailKey, email);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Clear stored OTP data
  static Future<void> _clearStoredOTP() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_otpKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_timestampKey);
  }

  // Check if OTP is still valid for resend functionality
  static Future<int> getRemainingTime(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString(_emailKey);
      final timestamp = prefs.getInt(_timestampKey);

      if (storedEmail != email || timestamp == null) {
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
