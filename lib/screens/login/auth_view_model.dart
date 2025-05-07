// // auth_view_model.dart
// import 'dart:convert';
// import 'package:admin_panel/screens/login/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   User? _user;
//   String? _token;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   User? get user => _user;

//   Future<void> init() async {
//     debugPrint("[init] Initializing AuthViewModel");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('authToken');
//     String? storedEmail = prefs.getString('loggedInUserEmail');

//     if (token != null && storedEmail != null) {
//       debugPrint(
//           "[init] Found stored credentials, attempting to fetch user info");
//       try {
//         await fetchUserInfo(token, storedEmail);
//         _token = token;
//         debugPrint("[init] User info fetched successfully, user is logged in");
//         debugPrint("[init] User: ${_user?.email}, ID: ${_user?.id}");
//       } catch (e) {
//         debugPrint("[init] Failed to initialize with stored token: $e");
//         await prefs.remove('authToken');
//         await prefs.remove('loggedInUserEmail');
//         await prefs.remove('userId');
//         _user = null;
//       }
//     } else {
//       debugPrint("[init] No stored credentials found");
//       _user = null;
//     }
//     notifyListeners();
//   }

//   Future<void> login(String email, String password, bool rememberMe,
//       BuildContext context) async {
//     debugPrint("[login] Login method called");
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     const String loginUrl = "http://75.119.134.82:6160/login";

//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       debugPrint("[login] Response status: ${response.statusCode}");
//       debugPrint("[login] Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _token = data['token'];
//         debugPrint("[login] Login successful, token received: $_token");

//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         if (rememberMe) {
//           await prefs.setString("authToken", data['token']);
//           await prefs.setString("loggedInUserEmail", email);
//         }

//         await fetchUserInfo(data['token'], email);
//         Navigator.pushReplacementNamed(context, 'DashboardView');
//       } else {
//         _errorMessage = "Invalid Email or Password";
//         debugPrint("[login] Login failed: $_errorMessage");
//       }
//     } catch (e) {
//       debugPrint("[login] Exception: $e");
//       _errorMessage = e.toString().replaceAll("Exception: ", "");
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> fetchUserInfo(String token, String email) async {
//     debugPrint("[fetchUserInfo] Fetching user info for email: $email");
//     const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

//     try {
//       final response = await http.get(
//         Uri.parse(userApi),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       debugPrint("[fetchUserInfo] Response status: ${response.statusCode}");
//       debugPrint("[fetchUserInfo] Raw body: ${response.body}");

//       if (response.statusCode == 200) {
//         final dynamic rawData = jsonDecode(response.body);
//         User? parsedUser;

//         if (rawData is List) {
//           final List<Map<String, dynamic>> data =
//               rawData.map((e) => Map<String, dynamic>.from(e)).toList();
//           debugPrint("[fetchUserInfo] Parsed user list length: ${data.length}");

//           final match = data.firstWhere(
//             (user) => user['email'] == email,
//             orElse: () => <String, dynamic>{},
//           );
//           debugPrint("[fetchUserInfo] Matched user: $match");

//           parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
//         }

//         if (parsedUser == null || parsedUser.id == null) {
//           debugPrint("[fetchUserInfo] Invalid user data structure");
//           throw Exception("Invalid user data structure");
//         }

//         if (parsedUser.role != 'ADMIN') {
//           debugPrint(
//               "[fetchUserInfo] User is not ADMIN, role: ${parsedUser.role}");
//           throw Exception("Only ADMIN users can log in");
//         }

//         _user = parsedUser;
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt("userId", parsedUser.id!);
//         debugPrint(
//             "[fetchUserInfo] User info set successfully, ID: ${parsedUser.id}");
//       } else {
//         debugPrint("[fetchUserInfo] Failed to fetch user details");
//         throw Exception("Failed to fetch user details");
//       }
//     } catch (e) {
//       debugPrint("[fetchUserInfo] Exception: $e");
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:admin_panel/screens/login/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  User? _user;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;
  // Updated: Added public getter for token
  String? get token => _token;

  Future<void> init() async {
    debugPrint("[init] Initializing AuthViewModel");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    String? storedEmail = prefs.getString('loggedInUserEmail');

    if (token != null && storedEmail != null) {
      debugPrint(
          "[init] Found stored credentials, attempting to fetch user info");
      try {
        await fetchUserInfo(token, storedEmail);
        _token = token;
        debugPrint("[init] User info fetched successfully, user is logged in");
        debugPrint("[init] User: ${_user?.email}, ID: ${_user?.id}");
      } catch (e) {
        debugPrint("[init] Failed to initialize with stored token: $e");
        await prefs.remove('authToken');
        await prefs.remove('loggedInUserEmail');
        await prefs.remove('userId');
        _user = null;
      }
    } else {
      debugPrint("[init] No stored credentials found");
      _user = null;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password, bool rememberMe,
      BuildContext context) async {
    debugPrint("[login] Login method called");
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    const String loginUrl = "http://75.119.134.82:6160/login";

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      debugPrint("[login] Response status: ${response.statusCode}");
      debugPrint("[login] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        debugPrint("[login] Login successful, token received: $_token");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (rememberMe) {
          await prefs.setString("authToken", data['token']);
          await prefs.setString("loggedInUserEmail", email);
        }

        await fetchUserInfo(data['token'], email);
        Navigator.pushReplacementNamed(context, 'DashboardView');
      } else {
        _errorMessage = "Invalid Email or Password";
        debugPrint("[login] Login failed: $_errorMessage");
      }
    } catch (e) {
      debugPrint("[login] Exception: $e");
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserInfo(String token, String email) async {
    debugPrint("[fetchUserInfo] Fetching user info for email: $email");
    const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

    try {
      final response = await http.get(
        Uri.parse(userApi),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint("[fetchUserInfo] Response status: ${response.statusCode}");
      debugPrint("[fetchUserInfo] Raw body: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic rawData = jsonDecode(response.body);
        User? parsedUser;

        if (rawData is List) {
          final List<Map<String, dynamic>> data =
              rawData.map((e) => Map<String, dynamic>.from(e)).toList();
          debugPrint("[fetchUserInfo] Parsed user list length: ${data.length}");

          final match = data.firstWhere(
            (user) => user['email'] == email,
            orElse: () => <String, dynamic>{},
          );
          debugPrint("[fetchUserInfo] Matched user: $match");

          parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
        }

        if (parsedUser == null || parsedUser.id == null) {
          debugPrint("[fetchUserInfo] Invalid user data structure");
          throw Exception("Invalid user data structure");
        }

        if (parsedUser.role != 'ADMIN') {
          debugPrint(
              "[fetchUserInfo] User is not ADMIN, role: ${parsedUser.role}");
          throw Exception("Only ADMIN users can log in");
        }

        _user = parsedUser;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("userId", parsedUser.id!);
        debugPrint(
            "[fetchUserInfo] User info set successfully, ID: ${parsedUser.id}");
      } else {
        debugPrint("[fetchUserInfo] Failed to fetch user details");
        throw Exception("Failed to fetch user details");
      }
    } catch (e) {
      debugPrint("[fetchUserInfo] Exception: $e");
      rethrow;
    }
  }
}
