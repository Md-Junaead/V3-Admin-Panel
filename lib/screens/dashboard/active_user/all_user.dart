import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nominee_view_model.dart';

class AllUser extends StatelessWidget {
  const AllUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NomineeViewModel()..fetchNominees(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            int flexValue =
                width > 1200 ? 8 : 12; // Adjust flex for large screens
            return Row(
              children: [
                Expanded(
                  flex: flexValue,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "This is all User Screen",
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: Consumer<NomineeViewModel>(
                          builder: (context, viewModel, child) {
                            if (viewModel.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (viewModel.errorMessage.isNotEmpty) {
                              return Center(
                                  child: Text(viewModel.errorMessage));
                            } else if (viewModel.nominees.isEmpty) {
                              return const Center(
                                  child: Text('No nominees found'));
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Email')),
                                    DataColumn(label: Text('Phone')),
                                    DataColumn(label: Text('Address')),
                                    DataColumn(label: Text('Nominee')),
                                  ],
                                  rows: viewModel.nominees.map((nominee) {
                                    return DataRow(cells: [
                                      DataCell(Text(nominee.user.name)),
                                      DataCell(Text(nominee.user.email)),
                                      DataCell(Text(nominee.user.phoneNo)),
                                      DataCell(Text(nominee.user.address)),
                                      DataCell(Text(nominee.name)),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<NomineeViewModel>().fetchNominees(),
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
