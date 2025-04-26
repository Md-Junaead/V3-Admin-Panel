import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/dashboard/deposit/deposit_model.dart';
import 'package:admin_panel/screens/sidebar/sidebar_view.dart';
import 'package:flutter/material.dart';

// Added new screen for deposit user details with modern UI
class DepositUserDetailScreen extends StatelessWidget {
  final Balance balance;
  const DepositUserDetailScreen({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // Updated line: Enhanced Row layout for modern design with sidebar
        children: [
          const Expanded(
            flex: 2,
            child:
                SidebarView(), // Updated line: Included SideBarView with modern styling
          ),
          Expanded(
            flex: 8,
            child: Scaffold(
              // Updated line: Wrapped content in inner Scaffold for modern app bar
              appBar: AppBar(
                title: const Text(
                  'Deposit Details',
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
                    backgroundColor: TColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                ),
                backgroundColor: TColors.buttonPrimary,
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
                            20.0), // Updated line: Added internal padding for card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                                'User ID', balance.userRegistration.userid),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow(
                                'Name', balance.userRegistration.name),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Country',
                                balance.userRegistration.country ?? 'N/A'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Add Balance',
                                '\$${balance.addBalance.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Deposit B',
                                '\$${balance.dipositB.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Packages', balance.packages),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Profit B',
                                '\$${balance.profitB.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Deposit Withdraw',
                                '\$${balance.dipositwithdra.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Profit Withdraw',
                                '\$${balance.profitwithdra.toStringAsFixed(2)}'),
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

  // Updated line: Added helper method for consistent detail row styling with text wrapping
  Widget _buildDetailRow(String label, String value) {
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
