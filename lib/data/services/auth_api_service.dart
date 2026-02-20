import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  static const String baseUrl = 'https://bukizz.in/api/v1';

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.toLowerCase(),
          'password': password,
        }),
      );
      print("Login Response Status: ${response.statusCode}");
      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Login failed');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print("Login API Connection Error: $e");
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Register
  Future<Map<String, dynamic>> register(String fullName, String email, String password, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email.toLowerCase(),
          'password': password,
          'phone': phone,
          'provider': 'email'
        }),
      );
      print("Register Response Status: ${response.statusCode}");
      print("Register Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Registration failed');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print("Register API Connection Error: $e");
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Forgot Password
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.toLowerCase()}),
      );
      print("Forgot Password Response Status: ${response.statusCode}");
      print("Forgot Password Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to send reset email');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print("Forgot Password API Connection Error: $e");
      throw Exception('Failed to connect to server: $e');
    }
    }

  // Google Login
  Future<Map<String, dynamic>> googleLogin(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/google-login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );
      print("Google Login Response Status: ${response.statusCode}");
      print("Google Login Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Google Login failed');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print("Google Login API Connection Error: $e");
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Refresh Token
  Future<String?> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');
      
      if (refreshToken == null) return null;

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['data']['accessToken'];
        final newRefreshToken = data['data']['refreshToken']; // Optionally update refresh token if provided
        await storeTokens(newAccessToken, newRefreshToken ?? refreshToken);
        return newAccessToken;
      } else {
        return null; // Refresh failed
      }
    } catch (e) {
      return null;
    }
  }

  // Store Tokens
  Future<void> storeTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  // Get Access Token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
  
  // Get Refresh Token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  // Clear Tokens
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }

  // Fetch Profile
  Future<Map<String, dynamic>> fetchProfile() async {
    try {
      final token = await getAccessToken();
      if (token == null) throw Exception('No access token');

      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        // Token expired, try refresh
        final newToken = await refreshToken();
        if (newToken != null) {
          // Retry with new token
          final retryResponse = await http.get(
            Uri.parse('$baseUrl/users/profile'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $newToken',
            },
          );
          if (retryResponse.statusCode == 200) {
            return jsonDecode(retryResponse.body);
          }
        }
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to fetch profile');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print("Fetch Profile Error: $e");
      throw e;
    }
  }
}
