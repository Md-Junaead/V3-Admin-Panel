import 'package:flutter/material.dart';

class EmiScreen extends StatelessWidget {
  const EmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "This is Emi Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
