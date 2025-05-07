// import 'package:admin_panel/configs/utils/constants/colors.dart';
// import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
// import 'package:admin_panel/screens/dashboard/user_details/user_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RegUserScreen extends StatefulWidget {
//   const RegUserScreen({super.key});

//   @override
//   State<RegUserScreen> createState() => _RegUserScreenState();
// }

// class _RegUserScreenState extends State<RegUserScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedSortOption = 'New';

//   @override
//   void initState() {
//     super.initState();
//     _debug("initState: Entered initState");
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _debug("PostFrameCallback: About to fetch users");
//       Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//       _debug("PostFrameCallback: fetchUsers called");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _debug("build: Building RegUserScreen");
//     final userViewModel = Provider.of<RegUserViewModel>(context);
//     _debug("build: Obtained userViewModel");

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: userViewModel.isLoading
//           ? Center(
//               child: const CircularProgressIndicator(),
//             )
//           : LayoutBuilder(
//               builder: (context, constraints) {
//                 _debug(
//                     "LayoutBuilder: constraints.maxWidth = ${constraints.maxWidth}");
//                 return SelectionArea(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'All Users',
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             _buildSearchBar(userViewModel),
//                             _buildSortDropdown(),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         _buildDataTable(context, constraints, userViewModel),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _debug("FloatingActionButton: Refresh pressed");
//           Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//           _debug("FloatingActionButton: fetchUsers called");
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }

//   Widget _buildSearchBar(RegUserViewModel userViewModel) {
//     _debug("_buildSearchBar: Building search bar widget");
//     return Container(
//       width: 320,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         decoration: const InputDecoration(
//           hintText: '🔍 Search by ID, Name, Email, Phone',
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           border: InputBorder.none,
//         ),
//         onChanged: (query) {
//           _debug("TextField onChanged: query = $query");
//           userViewModel.searchUsers(query);
//           _debug("TextField onChanged: searchUsers called");
//         },
//       ),
//     );
//   }

//   Widget _buildSortDropdown() {
//     _debug("_buildSortDropdown: Building sort dropdown widget");
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey, width: 1),
//       ),
//       child: DropdownButton<String>(
//         value: _selectedSortOption,
//         underline: const SizedBox(),
//         items: ['New', 'Old', 'Name', 'Email', 'Country'].map((option) {
//           _debug("Dropdown item: Adding option $option");
//           return DropdownMenuItem(
//             value: option,
//             child: Text(option),
//           );
//         }).toList(),
//         onChanged: (value) {
//           _debug("Dropdown onChanged: Selected value = $value");
//           setState(() {
//             _selectedSortOption = value!;
//             _debug(
//                 "setState: _selectedSortOption updated to $_selectedSortOption");
//           });
//           Provider.of<RegUserViewModel>(context, listen: false)
//               .sortUsers(value!);
//           _debug("Dropdown onChanged: sortUsers called with $value");
//         },
//       ),
//     );
//   }

//   Widget _buildDataTable(BuildContext context, BoxConstraints constraints,
//       RegUserViewModel userViewModel) {
//     _debug("_buildDataTable: Building data table widget");
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minWidth: constraints.maxWidth,
//         ),
//         child: DataTable(
//           border: TableBorder.all(color: Colors.black12),
//           headingRowHeight: 50,
//           headingRowColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//               _debug("DataTable headingRowColor callback invoked");
//               return TColors.buttonPrimary;
//             },
//           ),
//           columns: const [
//             DataColumn(label: Text('User ID', style: _tableHeaderTextStyle)),
//             DataColumn(label: Text('Name', style: _tableHeaderTextStyle)),
//             DataColumn(label: Text('Email', style: _tableHeaderTextStyle)),
//             DataColumn(label: Text('Phone No', style: _tableHeaderTextStyle)),
//             DataColumn(label: Text('Address', style: _tableHeaderTextStyle)),
//             DataColumn(label: Text('Country', style: _tableHeaderTextStyle)),
//           ],
//           rows: userViewModel.filteredUsers.map((user) {
//             _debug("Building DataRow for user: ${user.userid}");
//             return DataRow(
//               cells: [
//                 DataCell(
//                   GestureDetector(
//                     onTap: () {
//                       _debug(
//                           "DataCell onTap: Navigating to details for user: ${user.userid}");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserDetailScreen(
//                             userid: user.userid,
//                             name: user.name,
//                             email: user.email,
//                             phoneNo: user.phoneNo ?? 'N/A',
//                             address: user.address ?? 'N/A',
//                             country: user.country ?? 'N/A',
//                           ),
//                         ),
//                       );
//                       _debug("Navigation pushed for user: ${user.userid}");
//                     },
//                     child: Text(user.userid),
//                   ),
//                 ),
//                 DataCell(Text(user.name)),
//                 DataCell(Text(user.email)),
//                 DataCell(Text(user.phoneNo ?? 'N/A')),
//                 DataCell(Text(user.address ?? 'N/A')),
//                 DataCell(Text(user.country ?? 'N/A')),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   static const TextStyle _tableHeaderTextStyle = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//     fontSize: 16,
//   );

//   void _debug(String message) {
//     debugPrint("[DEBUG] $message");
//   }
// }

import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
import 'package:admin_panel/screens/dashboard/user_details/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/screens/login/auth_view_model.dart'; // Updated: Added import for AuthViewModel

class RegUserScreen extends StatefulWidget {
  const RegUserScreen({super.key});

  @override
  State<RegUserScreen> createState() => _RegUserScreenState();
}

class _RegUserScreenState extends State<RegUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSortOption = 'New';

  @override
  void initState() {
    super.initState();
    _debug("initState: Entered initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _debug("PostFrameCallback: About to fetch users");
      // Updated: Retrieve token from AuthViewModel and pass to fetchUsers
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final token = authViewModel.token;
      if (token != null) {
        Provider.of<RegUserViewModel>(context, listen: false).fetchUsers(token);
        _debug("PostFrameCallback: fetchUsers called with token");
      } else {
        _debug(
            "PostFrameCallback: No token found - admin may not be logged in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _debug("build: Building RegUserScreen");
    final userViewModel = Provider.of<RegUserViewModel>(context);
    _debug("build: Obtained userViewModel");

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: userViewModel.isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                _debug(
                    "LayoutBuilder: constraints.maxWidth = ${constraints.maxWidth}");
                return SelectionArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All Users',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            _buildSearchBar(userViewModel),
                            _buildSortDropdown(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildDataTable(context, constraints, userViewModel),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _debug("FloatingActionButton: Refresh pressed");
          // Updated: Retrieve token from AuthViewModel and pass to fetchUsers
          final authViewModel =
              Provider.of<AuthViewModel>(context, listen: false);
          final token = authViewModel.token;
          if (token != null) {
            Provider.of<RegUserViewModel>(context, listen: false)
                .fetchUsers(token);
            _debug("FloatingActionButton: fetchUsers called with token");
          } else {
            _debug(
                "FloatingActionButton: No token found - admin may not be logged in");
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSearchBar(RegUserViewModel userViewModel) {
    _debug("_buildSearchBar: Building search bar widget");
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: '🔍 Search by ID, Name, Email, Phone',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
        onChanged: (query) {
          _debug("TextField onChanged: query = $query");
          userViewModel.searchUsers(query);
          _debug("TextField onChanged: searchUsers called");
        },
      ),
    );
  }

  Widget _buildSortDropdown() {
    _debug("_buildSortDropdown: Building sort dropdown widget");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButton<String>(
        value: _selectedSortOption,
        underline: const SizedBox(),
        items: ['New', 'Old', 'Name', 'Email', 'Country'].map((option) {
          _debug("Dropdown item: Adding option $option");
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          _debug("Dropdown onChanged: Selected value = $value");
          setState(() {
            _selectedSortOption = value!;
            _debug(
                "setState: _selectedSortOption updated to $_selectedSortOption");
          });
          Provider.of<RegUserViewModel>(context, listen: false)
              .sortUsers(value!);
          _debug("Dropdown onChanged: sortUsers called with $value");
        },
      ),
    );
  }

  Widget _buildDataTable(BuildContext context, BoxConstraints constraints,
      RegUserViewModel userViewModel) {
    _debug("_buildDataTable: Building data table widget");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: constraints.maxWidth,
        ),
        child: DataTable(
          border: TableBorder.all(color: Colors.black12),
          headingRowHeight: 50,
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              _debug("DataTable headingRowColor callback invoked");
              return TColors.buttonPrimary;
            },
          ),
          columns: const [
            DataColumn(label: Text('User ID', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Name', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Email', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Phone No', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Address', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Country', style: _tableHeaderTextStyle)),
          ],
          rows: userViewModel.filteredUsers.map((user) {
            _debug("Building DataRow for user: ${user.userid}");
            return DataRow(
              cells: [
                DataCell(
                  GestureDetector(
                    onTap: () {
                      _debug(
                          "DataCell onTap: Navigating to details for user: ${user.userid}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(
                            userid: user.userid,
                            name: user.name,
                            email: user.email,
                            phoneNo: user.phoneNo ?? 'N/A',
                            address: user.address ?? 'N/A',
                            country: user.country ?? 'N/A',
                          ),
                        ),
                      );
                      _debug("Navigation pushed for user: ${user.userid}");
                    },
                    child: Text(user.userid),
                  ),
                ),
                DataCell(Text(user.name)),
                DataCell(Text(user.email)),
                DataCell(Text(user.phoneNo ?? 'N/A')),
                DataCell(Text(user.address ?? 'N/A')),
                DataCell(Text(user.country ?? 'N/A')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  static const TextStyle _tableHeaderTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );

  void _debug(String message) {
    debugPrint("[DEBUG] $message");
  }
}
