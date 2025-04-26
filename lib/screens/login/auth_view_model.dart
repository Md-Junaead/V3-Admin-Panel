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

//   // Added to initialize authentication state on app start
//   Future<void> init() async {
//     debugPrint("Initializing AuthViewModel");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('authToken');
//     if (token != null) {
//       debugPrint("Found stored token, attempting to fetch user info");
//       try {
//         await fetchUserInfo(token);
//         _token = token; // Set session token if fetch succeeds
//         debugPrint("User info fetched successfully, user is logged in");
//       } catch (e) {
//         debugPrint("Failed to initialize with stored token: $e");
//         // Clear invalid token and related data
//         await prefs.remove('authToken');
//         await prefs.remove('loggedInUserEmail');
//         await prefs.remove('userId');
//         _user = null;
//       }
//     } else {
//       debugPrint("No stored token found");
//       _user = null;
//     }
//     notifyListeners();
//   }

//   /// Handles user login
//   Future<void> login(String email, String password, bool rememberMe,
//       BuildContext context) async {
//     debugPrint("Login method called");
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//     debugPrint("Loading state set to true");

//     const String loginUrl = "http://75.119.134.82:6160/login";

//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"email": email, "password": password}),
//       );
//       debugPrint("Login request sent");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         debugPrint("Login Successful: $data");

//         // Store token in memory for current session
//         _token = data['token'];

//         // Store in SharedPreferences only if rememberMe is true
//         if (rememberMe) {
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString("authToken", data['token']);
//           await prefs.setString("loggedInUserEmail", email);
//           debugPrint("Auth token and email saved");
//         }

//         await fetchUserInfo(data['token']);
//         debugPrint("User info fetched successfully");

//         Navigator.pushReplacementNamed(context, 'BottomNavBar');
//         debugPrint("Navigated to BottomNavBar");
//       } else {
//         _errorMessage = "Invalid Email or Password";
//         debugPrint("Login Failed: ${response.body}");
//       }
//     } catch (e) {
//       _errorMessage = "Invalid Email or Password";
//       debugPrint("Login Error: $e");
//     }

//     _isLoading = false;
//     notifyListeners();
//     debugPrint("Loading state set to false");
//   }

//   /// Fetches logged-in user's information
//   Future<void> fetchUserInfo(String token) async {
//     debugPrint("Fetching user info...");
//     const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

//     try {
//       final response = await http.get(
//         Uri.parse(userApi),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       debugPrint("User info request sent");

//       if (response.statusCode == 200) {
//         final dynamic rawData = jsonDecode(response.body);
//         debugPrint("User info response received: $rawData");

//         final prefs = await SharedPreferences.getInstance();
//         final storedEmail = prefs.getString('loggedInUserEmail');
//         debugPrint("Stored email retrieved: $storedEmail");

//         User? parsedUser;
//         if (rawData is List) {
//           debugPrint("Received user list (${rawData.length} entries)");
//           final List<Map<String, dynamic>> data =
//               rawData.map((e) => Map<String, dynamic>.from(e)).toList();
//           final match = data.firstWhere(
//             (user) => user['email'] == storedEmail,
//             orElse: () => <String, dynamic>{},
//           );
//           parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
//         } else if (rawData is Map) {
//           debugPrint("Received single user data");
//           final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
//           parsedUser = User.fromJson(data);
//         }

//         if (parsedUser != null && parsedUser.id != null) {
//           _user = parsedUser;
//           await prefs.setInt("userId", parsedUser.id!);
//           debugPrint("User ID ${parsedUser.id} stored for ${parsedUser.email}");
//         } else {
//           debugPrint(
//               "User data incomplete. ID: ${parsedUser?.id}, Email match: $storedEmail");
//           throw Exception("Invalid user data structure");
//         }
//       } else {
//         debugPrint("User fetch failed: ${response.body}");
//         throw Exception("Failed to fetch user details");
//       }
//     } catch (e) {
//       debugPrint("User info error: $e");
//       rethrow;
//     }
//   }

// }

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
//     debugPrint("Initializing AuthViewModel");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('authToken');
//     String? storedEmail = prefs.getString('loggedInUserEmail');

//     if (token != null && storedEmail != null) {
//       debugPrint("Found stored credentials, attempting to fetch user info");
//       try {
//         await fetchUserInfo(token, storedEmail);
//         _token = token;
//         debugPrint("User info fetched successfully, user is logged in");
//       } catch (e) {
//         debugPrint("Failed to initialize with stored token: $e");
//         await prefs.remove('authToken');
//         await prefs.remove('loggedInUserEmail');
//         await prefs.remove('userId');
//         _user = null;
//       }
//     } else {
//       debugPrint("No stored credentials found");
//       _user = null;
//     }
//     notifyListeners();
//   }

//   Future<void> login(String email, String password, bool rememberMe,
//       BuildContext context) async {
//     debugPrint("Login method called");
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

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _token = data['token'];

//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         if (rememberMe) {
//           await prefs.setString("authToken", data['token']);
//           await prefs.setString("loggedInUserEmail", email);
//         }

//         // Pass email directly to fetchUserInfo
//         await fetchUserInfo(data['token'], email);

//         Navigator.pushReplacementNamed(context, 'BottomNavBar');
//       } else {
//         _errorMessage = "Invalid Email or Password";
//       }
//     } catch (e) {
//       _errorMessage = e.toString().replaceAll("Exception: ", "");
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> fetchUserInfo(String token, String email) async {
//     debugPrint("Fetching user info for email: $email");
//     const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

//     try {
//       final response = await http.get(
//         Uri.parse(userApi),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final dynamic rawData = jsonDecode(response.body);
//         User? parsedUser;

//         if (rawData is List) {
//           final List<Map<String, dynamic>> data =
//               rawData.map((e) => Map<String, dynamic>.from(e)).toList();
//           final match = data.firstWhere(
//             (user) => user['email'] == email,
//             orElse: () => <String, dynamic>{},
//           );
//           parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
//         }

//         if (parsedUser == null || parsedUser.id == null) {
//           throw Exception("Invalid user data structure");
//         }

//         // Admin validation check
//         if (parsedUser.role != 'ADMIN') {
//           throw Exception("Only ADMIN users can log in");
//         }

//         _user = parsedUser;
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt("userId", parsedUser.id!);
//       } else {
//         throw Exception("Failed to fetch user details");
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// auth_view_model.dart
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
