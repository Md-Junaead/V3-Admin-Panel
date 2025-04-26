import 'package:admin_panel/screens/dashboard/deposit/deposit_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepositViewModel extends ChangeNotifier {
  // Lists to hold balance data
  List<Balance> _balances = []; // Use Balance instead of DepositModel
  List<Balance> _filteredBalances = []; // Use Balance
  bool _isLoading = false;

  // Getter for the balance list
  List<Balance> get balances =>
      _filteredBalances.isEmpty ? _balances : _filteredBalances;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Fetch balances from API
  Future<void> fetchBalances() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://75.119.134.82:6160/api/Balance/get');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _balances = data.map((json) => Balance.fromJson(json)).toList();
        _filteredBalances = _balances; // Initially, no filters
      }
    } catch (e) {
      print('Error fetching balances: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  // Search balances by UserID or Name
  void searchBalances(String query) {
    _filteredBalances = _balances
        .where((balance) =>
            balance.userRegistration.userid
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            balance.userRegistration.name
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // Sort balances by a field
  void sortBalances(String option) {
    switch (option) {
      case 'New':
        _balances.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Old':
        _balances.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'Name':
        _balances.sort((a, b) =>
            a.userRegistration.name.compareTo(b.userRegistration.name));
        break;
      case 'Country':
        _balances.sort((a, b) => (a.userRegistration.country ?? '')
            .toLowerCase()
            .compareTo((b.userRegistration.country ?? '').toLowerCase()));
        break;
    }
    _filteredBalances = _balances; // Reset filtered list after sorting
    notifyListeners();
  }
}
