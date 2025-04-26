import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_provider.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoanTable extends StatefulWidget {
  const LoanTable({super.key});

  @override
  _LoanTableState createState() => _LoanTableState();
}

class _LoanTableState extends State<LoanTable> {
  @override
  void initState() {
    super.initState();
    // Fetch loan data when screen initializes
    Provider.of<LoanProvider>(context, listen: false)
        .fetchLoanData(); // Updated: Changed LoanDataProvider to LoanProvider
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    String selectedSortOption = 'New';

    return Scaffold(
      backgroundColor: Colors.grey[100], // Correct in provided code
      body: Consumer<LoanProvider>(
          // Updated: Changed LoanDataProvider to LoanProvider
          builder: (context, loanProvider, child) {
        // Updated: Changed variable name to loanProvider
        return loanProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;

                  // Determine layout based on screen size
                  bool isLargeScreen = maxWidth > 1200;
                  bool isMediumScreen = maxWidth > 800 && maxWidth <= 1200;

                  return SingleChildScrollView(
                    padding:
                        const EdgeInsets.all(12.0), // Correct in provided code
                    child: Column(
                      children: [
                        // Table Header: Title, Search Bar, Sort Dropdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Screen Title
                            const Text(
                              'Loan Table',
                              style: TextStyle(
                                fontSize: 26, // Correct in provided code
                                fontWeight:
                                    FontWeight.bold, // Correct in provided code
                                color: Colors.black,
                              ),
                            ),
                            // Search Bar
                            Container(
                              width: isLargeScreen
                                  ? 400
                                  : isMediumScreen
                                      ? 300
                                      : 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: '🔍 Search by UserID or Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  border: InputBorder.none,
                                ),
                                onChanged: (query) {
                                  loanProvider.updateSearchQuery(
                                      query); // Updated: Changed to loanProvider
                                },
                              ),
                            ),
                            // Sort Dropdown
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isLargeScreen ? 16 : 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: DropdownButton<String>(
                                value: selectedSortOption,
                                underline: SizedBox(), // Remove default line
                                items: ['New', 'Old']
                                    .map((option) => DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedSortOption = value!;
                                  loanProvider.updateSortOption(
                                      value); // Updated: Changed to loanProvider
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Data Table with Fixed Header
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: SingleChildScrollView(
                              child: DataTable(
                                columnSpacing: isLargeScreen ? 15 : 10,
                                border: TableBorder.all(color: Colors.black12),
                                headingRowHeight: 50,
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return TColors
                                        .buttonPrimary; // Table header color
                                  },
                                ),
                                columns: const [
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Loan ID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'UserID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Loan Amount',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Weekly Pay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Total Pay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Tenure',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Request Date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                ],
                                rows: loanProvider.loans
                                    .where((loan) =>
                                        loan.userRegistration.name
                                            .toLowerCase()
                                            .contains(loanProvider.searchQuery
                                                .toLowerCase()) ||
                                        loan.id
                                            .toString()
                                            .contains(loanProvider.searchQuery))
                                    .map((loan) {
                                  return DataRow(cells: [
                                    DataCell(Text(loan.id.toString())),
                                    // Modified: Made userID clickable to navigate to UserDetailScreen
                                    // Inside the DataRow mapping in LoanTable
                                    DataCell(
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate to the LoanUser DetailScreen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoanUserDetailScreen(
                                                // Added this line
                                                loan:
                                                    loan, // Pass the loan object to the LoanUser DetailScreen
                                              ),
                                            ),
                                          );
                                        },
                                        child:
                                            Text(loan.userRegistration.userid),
                                      ),
                                    ),
                                    DataCell(Text(loan.userRegistration.name)),
                                    DataCell(Text(loan.loanamuont.toString())),
                                    DataCell(Text(
                                        loan.weeklypay.toStringAsFixed(2))),
                                    DataCell(
                                        Text(loan.totalpay.toStringAsFixed(2))),
                                    DataCell(Text(loan.tenure.toString())),
                                    DataCell(Text(loan.status)),
                                    DataCell(Text(loanProvider.formatDate(loan
                                        .requestdate
                                        .toIso8601String()))), // Updated: Convert DateTime to String for formatDate
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh the loan data when pressed
          Provider.of<LoanProvider>(context, listen: false)
              .fetchLoanData(); // Updated: Changed LoanDataProvider to LoanProvider
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
