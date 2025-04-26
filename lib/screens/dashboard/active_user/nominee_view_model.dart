// nominee_view_model.dart (ViewModel)
import 'package:flutter/material.dart';
import 'nominee_service.dart';
import 'nominee_model.dart';

class NomineeViewModel extends ChangeNotifier {
  final NomineeService _service = NomineeService();
  List<Nominee> _nominees = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Nominee> get nominees => _nominees;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNominees() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _nominees = await _service.fetchNominees();
    } catch (e) {
      _errorMessage = 'Failed to load nominees';
    }

    _isLoading = false;
    notifyListeners();
  }
}
