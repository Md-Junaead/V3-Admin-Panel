// loan.dart
import 'package:admin_panel/screens/dashboard/loan/loan_table.dart';
import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Updated: Already correct in provided code, but explicitly typed as BuildContext for clarity
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: LoanTable(), // Integrate LoanTable here
          ),
        ],
      ),
    );
  }
}
