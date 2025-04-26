// import 'package:admin_panel/configs/utils/constants/colors.dart';
// import 'package:admin_panel/screens/sidebar/sidebar_view.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_panel/screens/dashboard/loan/loan_model.dart'; // Import the LoanModel

// class LoanUserDetailScreen extends StatelessWidget {
//   final LoanModel loan;

//   const LoanUserDetailScreen({super.key, required this.loan});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         // Updated line: Add Row layout to include sidebar and content
//         children: [
//           const Expanded(
//             flex: 2,
//             child:
//                 SidebarView(), // Updated line: Include SidebarView on the left side
//           ),
//           Expanded(
//             flex: 8,
//             child: Scaffold(
//               // Updated line: Wrap content in an inner Scaffold for modern app bar
//               appBar: AppBar(
//                 title: const Text(
//                   'Loan Details',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 leading: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context); // Go back to the previous screen
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         TColors.buttonPrimary, // Use a custom primary color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 4,
//                   ),
//                 ),
//                 backgroundColor:
//                     TColors.buttonPrimary, // Custom color for AppBar
//                 elevation: 4,
//               ),
//               body: Container(
//                 color: Colors
//                     .grey[100], // Updated background color for modern look
//                 child: Padding(
//                   padding: const EdgeInsets.all(
//                       24.0), // Increased padding for modern spacing
//                   child: SingleChildScrollView(
//                     child: Card(
//                       // Added Card for elevated modern design
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(
//                             20.0), // Added internal padding for card
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildDetailRow(
//                                 'User ID', loan.userRegistration.userid),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Name', loan.userRegistration.name),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow(
//                                 'Email', loan.userRegistration.email),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Eligible Balance',
//                                 '\$${loan.eligeblebalancey.toStringAsFixed(2)}'),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Loan Amount',
//                                 '\$${loan.loanamuont.toStringAsFixed(2)}'),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Weekly Pay',
//                                 '\$${loan.weeklypay.toStringAsFixed(2)}'),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Total Pay',
//                                 '\$${loan.totalpay.toStringAsFixed(2)}'),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Tenure', loan.tenure.toString()),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Status', loan.status),
//                             const Divider(
//                               height: 5,
//                               thickness: 1,
//                               color: Colors.grey,
//                             ),
//                             _buildDetailRow('Request Date',
//                                 loan.requestdate.toIso8601String()),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Updated line: Added helper method for consistent detail row styling with text wrapping
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           Flexible(
//             child: Text(
//               value,
//               softWrap: true,
//               style: const TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:admin_panel/configs/utils/constants/colors.dart';
// import 'package:admin_panel/screens/sidebar/sidebar_view.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
// import 'package:admin_panel/screens/dashboard/loan/loan_provider.dart';
// import 'package:provider/provider.dart';

// // Modified: Changed to StatefulWidget to manage dropdown state
// class LoanUserDetailScreen extends StatefulWidget {
//   final LoanModel loan;

//   const LoanUserDetailScreen({super.key, required this.loan});

//   @override
//   _LoanUserDetailScreenState createState() => _LoanUserDetailScreenState();
// }

// class _LoanUserDetailScreenState extends State<LoanUserDetailScreen> {
//   late String _selectedStatus; // Local state for dropdown selection

//   @override
//   void initState() {
//     super.initState();
//     _selectedStatus = widget.loan.status; // Initialize with current status
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Access LoanProvider to listen for updates and call methods
//     final loanProvider = Provider.of<LoanProvider>(context);

//     return Scaffold(
//       body: Row(
//         children: [
//           const Expanded(
//             flex: 2,
//             child: SidebarView(),
//           ),
//           Expanded(
//             flex: 8,
//             child: Scaffold(
//               appBar: AppBar(
//                 title: const Text(
//                   'Loan Details',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 leading: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: TColors.buttonPrimary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 4,
//                   ),
//                 ),
//                 backgroundColor: TColors.buttonPrimary,
//                 elevation: 4,
//               ),
//               body: Container(
//                 color: Colors.grey[100],
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: SingleChildScrollView(
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildDetailRow(
//                                 'User ID', widget.loan.userRegistration.userid),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow(
//                                 'Name', widget.loan.userRegistration.name),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow(
//                                 'Email', widget.loan.userRegistration.email),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Eligible Balance',
//                                 '\$${widget.loan.eligeblebalancey.toStringAsFixed(2)}'),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Loan Amount',
//                                 '\$${widget.loan.loanamuont.toStringAsFixed(2)}'),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Weekly Pay',
//                                 '\$${widget.loan.weeklypay.toStringAsFixed(2)}'),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Total Pay',
//                                 '\$${widget.loan.totalpay.toStringAsFixed(2)}'),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow(
//                                 'Tenure', widget.loan.tenure.toString()),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Status', widget.loan.status),
//                             const Divider(
//                                 height: 5, thickness: 1, color: Colors.grey),
//                             _buildDetailRow('Request Date',
//                                 widget.loan.requestdate.toIso8601String()),
//                             // New: Added dropdown and submit button below Request Date
//                             const SizedBox(
//                                 height: 20), // Spacing before new UI elements
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Update Status',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 DropdownButton<String>(
//                                   value: _selectedStatus,
//                                   items: ['Pending', 'Approve', 'Reject']
//                                       .map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       _selectedStatus =
//                                           newValue!; // Update local status
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20), // Spacing before button
//                             Center(
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   // Call provider method to update status
//                                   await loanProvider.updateLoanStatus(
//                                       widget.loan, _selectedStatus);
//                                   // Note: UI rebuilds automatically due to notifyListeners in provider
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors
//                                       .blue, // Blue background as requested
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30, vertical: 15),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Submit',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16), // White text as requested
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           Flexible(
//             child: Text(
//               value,
//               softWrap: true,
//               style: const TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/sidebar/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_provider.dart';
import 'package:provider/provider.dart';

class LoanUserDetailScreen extends StatefulWidget {
  final LoanModel loan;
  const LoanUserDetailScreen({super.key, required this.loan});

  @override
  _LoanUserDetailScreenState createState() => _LoanUserDetailScreenState();
}

class _LoanUserDetailScreenState extends State<LoanUserDetailScreen> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.loan.status;
  }

  @override
  Widget build(BuildContext context) {
    final loanProvider = Provider.of<LoanProvider>(context);

    return Scaffold(
      body: Row(
        children: [
          const Expanded(flex: 2, child: SidebarView()),
          Expanded(
            flex: 8,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Loan Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
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
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                                'User ID', widget.loan.userRegistration.userid),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow(
                                'Name', widget.loan.userRegistration.name),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow(
                                'Email', widget.loan.userRegistration.email),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Eligible Balance',
                                '\$${widget.loan.eligeblebalancey.toStringAsFixed(2)}'),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Loan Amount',
                                '\$${widget.loan.loanamuont.toStringAsFixed(2)}'),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Weekly Pay',
                                '\$${widget.loan.weeklypay.toStringAsFixed(2)}'),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Total Pay',
                                '\$${widget.loan.totalpay.toStringAsFixed(2)}'),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow(
                                'Tenure', widget.loan.tenure.toString()),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Status', widget.loan.status),
                            const Divider(
                                height: 5, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Request Date',
                                widget.loan.requestdate.toIso8601String()),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Update Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _selectedStatus,
                                  items: ['Pending', 'Approve', 'Reject']
                                      .map((String v) => DropdownMenuItem(
                                            value: v,
                                            child: Text(v),
                                          ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    setState(() => _selectedStatus = newValue!);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    debugPrint(
                                        "Submit pressed. New status: $_selectedStatus"); // 👉 Added
                                    await loanProvider.updateLoanStatus(
                                        widget.loan, _selectedStatus);
                                    debugPrint("Update successful"); // 👉 Added

                                    // 👉 Added: success popup
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        backgroundColor: Colors.black,
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              'Status updated!',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    debugPrint("Update failed: $e"); // 👉 Added

                                    // 👉 Added: error popup
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        backgroundColor: Colors.black,
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              'Error: ${e.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
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
                color: Colors.black87),
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
