import 'dart:convert';
import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 👉 Added

class LoanProvider with ChangeNotifier {
  List<LoanModel> _loans = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _searchQuery = '';
  String _sortOption = 'New';

  List<LoanModel> get loans => _loans;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;

  Future<void> fetchLoanData() async {
    final url = 'http://75.119.134.82:6160/api/loan/get';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _loans = data.map((loan) => LoanModel.fromJson(loan)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Error fetching data: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSortOption(String option) {
    _sortOption = option;
    _loans.sort((a, b) {
      if (option == 'New') {
        return b.requestdate.compareTo(a.requestdate);
      } else {
        return a.requestdate.compareTo(b.requestdate);
      }
    });
    notifyListeners();
  }

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day.toString().padLeft(2, '0')}/"
          "${parsedDate.month.toString().padLeft(2, '0')}/"
          "${parsedDate.year}";
    } catch (e) {
      return date;
    }
  }

  Future<void> updateLoanStatus(LoanModel loan, String newStatus) async {
    loan.status = newStatus;
    final url = 'http://75.119.134.82:6160/api/loan/save';

    try {
      // 👉 Added: fetch token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';

      debugPrint(
          "Updating status to '$newStatus' with token $token"); // 👉 Added

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 👉 Added
        },
        body: json.encode(loan.toJson()),
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Success: ${response.body}");
        notifyListeners();
      } else {
        debugPrint("❌ Fail ${response.statusCode} – ${response.body}");
        throw Exception('Failed to update loan status: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint("❗ Exception: $error");
      throw error;
    }
  }
}
