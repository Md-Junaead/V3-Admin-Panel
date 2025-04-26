import 'package:admin_panel/screens/dashboard/all_user/reg_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegUserViewModel extends ChangeNotifier {
  List<UserRegistration> _users = [];
  List<UserRegistration> _filteredUsers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<UserRegistration> get users => _users;
  List<UserRegistration> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading;

  // Debug method to log errors and execution flow
  void _debug(String message) {
    print("[DEBUG] $message");
  }

  // Fetch users from API
  Future<void> fetchUsers() async {
    _isLoading = true;
    _debug("Set _isLoading to true");
    notifyListeners();
    _debug("Called notifyListeners after setting loading true");

    try {
      _debug("Fetching users from API...");
      final response = await http.get(
        Uri.parse('http://75.119.134.82:6160/api/userRegistration/get'),
      );
      _debug("HTTP GET request complete");

      _debug("Response status code: ${response.statusCode}");
      _debug("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _debug("Decoded JSON data: $data");
        _users = data.map((user) {
          _debug("Mapping user: $user");
          return UserRegistration.fromJson(user);
        }).toList();
        _debug("Mapped all users: ${_users.length} items");
        _filteredUsers = List.from(_users);
        _debug("Initialized _filteredUsers with _users data");
      } else {
        _debug("Failed to fetch users: Status Code ${response.statusCode}");
      }
    } catch (e) {
      _debug("Error fetching users: $e");
    }

    _isLoading = false;
    _debug("Set _isLoading to false");
    notifyListeners();
    _debug("Called notifyListeners after fetching users");
  }

  // Method to search users (includes UserID, Name, Email, Phone Number)
  void searchUsers(String query) {
    _debug("Entered searchUsers with query: $query");
    _searchQuery = query;
    _debug("Set _searchQuery to: $_searchQuery");
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
      _debug("Query is empty; copied _users to _filteredUsers");
    } else {
      try {
        _filteredUsers = _users.where((user) {
          bool condition =
              (user.userid.toLowerCase().contains(query.toLowerCase())) ||
                  (user.name.toLowerCase().contains(query.toLowerCase())) ||
                  (user.email.toLowerCase().contains(query.toLowerCase())) ||
                  (user.phoneNo?.toLowerCase().contains(query.toLowerCase()) ??
                      false);
          _debug("User ${user.userid} matches search? $condition");
          return condition;
        }).toList();
        _debug("Filtered users count: ${_filteredUsers.length}");
      } catch (e) {
        _debug("Error in searchUsers: $e");
      }
    }
    notifyListeners();
    _debug("Called notifyListeners after searchUsers");
  }

  // Method to sort users by various criteria
  void sortUsers(String sortBy) {
    _debug("Entered sortUsers with sortBy: $sortBy");
    try {
      if (sortBy == 'New') {
        _filteredUsers =
            List.from(_users); // Keep original order (newest first)
        _debug("Sorting by New: _filteredUsers set to _users list");
      } else if (sortBy == 'Old') {
        _filteredUsers = List.from(_users.reversed); // Reverse the list
        _debug("Sorting by Old: _filteredUsers reversed");
      } else if (sortBy == 'Name') {
        _filteredUsers.sort((a, b) {
          int result = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          _debug("Comparing ${a.name} and ${b.name}: $result");
          return result;
        });
        _debug("Sorting by Name completed");
      } else if (sortBy == 'Email') {
        _filteredUsers.sort((a, b) {
          int result = a.email.toLowerCase().compareTo(b.email.toLowerCase());
          _debug("Comparing ${a.email} and ${b.email}: $result");
          return result;
        });
        _debug("Sorting by Email completed");
      } else if (sortBy == 'Country') {
        _filteredUsers.sort((a, b) {
          int result = (a.country ?? "")
              .toLowerCase()
              .compareTo((b.country ?? "").toLowerCase());
          _debug("Comparing ${a.country} and ${b.country}: $result");
          return result;
        });

        _debug("Sorting by Country completed");
      }
    } catch (e) {
      _debug("Error in sortUsers: $e");
    }
    notifyListeners();
    _debug("Called notifyListeners after sortUsers");
  }
}
