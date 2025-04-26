import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/dashboard/deposit/deposit_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deposit_view_model.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    String selectedSortOption = 'New';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<DepositViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deposit Details',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 320,
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
                                  decoration: InputDecoration(
                                    hintText: '🔍 Search by ID or Name',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (query) {
                                    viewModel.searchBalances(query);
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedSortOption,
                                  underline: SizedBox(),
                                  items: ['New', 'Old', 'Name', 'Country']
                                      .map((option) => DropdownMenuItem(
                                            value: option,
                                            child: Text(option),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedSortOption = value!;
                                    viewModel.sortBalances(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 25,
                              border: TableBorder.all(color: Colors.black12),
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return TColors.buttonPrimary;
                                },
                              ),
                              columns: [
                                DataColumn(
                                    label: Text('ID', style: _headerStyle())),
                                DataColumn(
                                    label:
                                        Text('User ID', style: _headerStyle())),
                                DataColumn(
                                    label: Text('Name', style: _headerStyle())),
                                DataColumn(
                                    label:
                                        Text('Country', style: _headerStyle())),
                                DataColumn(
                                    label: Text('Add Balance',
                                        style: _headerStyle())),
                                DataColumn(
                                    label: Text('Deposit B',
                                        style: _headerStyle())),
                                DataColumn(
                                    label: Text('Packages',
                                        style: _headerStyle())),
                                DataColumn(
                                    label: Text('Profit B',
                                        style: _headerStyle())),
                                DataColumn(
                                    label: Text('Deposit Withdraw',
                                        style: _headerStyle())),
                                DataColumn(
                                    label: Text('Profit Withdraw',
                                        style: _headerStyle())),
                              ],
                              rows: viewModel.balances.map((balance) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(balance.id.toString())),
                                    DataCell(
                                      // Changed: Navigating to DepositUserDetailScreen
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DepositUserDetailScreen(
                                                      balance: balance),
                                            ),
                                          );
                                        },
                                        child: Text(
                                            balance.userRegistration.userid),
                                      ),
                                    ),
                                    DataCell(
                                        Text(balance.userRegistration.name)),
                                    DataCell(Text(
                                        balance.userRegistration.country ??
                                            'N/A')),
                                    DataCell(
                                        Text(balance.addBalance.toString())),
                                    DataCell(Text(balance.dipositB.toString())),
                                    DataCell(Text(balance.packages)),
                                    DataCell(Text(
                                        balance.profitB.toStringAsFixed(2))),
                                    DataCell(Text(
                                        balance.dipositwithdra.toString())),
                                    DataCell(
                                        Text(balance.profitwithdra.toString())),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DepositViewModel>().fetchBalances();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
    );
  }
}
