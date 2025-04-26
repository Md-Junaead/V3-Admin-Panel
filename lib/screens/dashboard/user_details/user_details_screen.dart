import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/sidebar/sidebar_view.dart'; // Updated line: import SidebarView

class UserDetailScreen extends StatelessWidget {
  final String userid;
  final String name;
  final String email;
  final String phoneNo;
  final String address;
  final String country;
  final DateTime? dob;
  final String? nidnumber;
  final String? passport;

  const UserDetailScreen({
    super.key,
    required this.userid,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.country,
    this.dob,
    this.nidnumber,
    this.passport,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // Updated line: Add Row to include sidebar and content
        children: [
          const Expanded(
            flex: 2,
            child:
                SidebarView(), // Updated line: Include SidebarView on the left side
          ),
          Expanded(
            flex: 8,
            child: Scaffold(
              // Updated line: Wrap content in an inner Scaffold for a modern AppBar
              appBar: AppBar(
                title: const Text(
                  'User Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        TColors.buttonPrimary, // Update button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                ),
                backgroundColor: TColors
                    .buttonPrimary, // Updated line: Modern background color
                elevation: 4,
              ),
              body: Container(
                color: Colors.grey[
                    100], // Updated line: Set background color for modern look
                child: Padding(
                  padding: const EdgeInsets.all(
                      24.0), // Updated line: Increased padding for modern spacing
                  child: SingleChildScrollView(
                    child: Card(
                      // Updated line: Added Card for elevated modern design
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            20.0), // Updated line: Added internal padding for the card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserDetailRow('User ID:', userid),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildUserDetailRow('Name:', name),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildUserDetailRow('Email:', email),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildUserDetailRow('Phone No:', phoneNo),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildUserDetailRow('Address:', address),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildUserDetailRow('Country:', country),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            // Add more details if needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build user details rows with consistent styling
  Widget _buildUserDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Flexible(
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
