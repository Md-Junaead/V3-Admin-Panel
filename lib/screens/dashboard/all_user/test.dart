// import 'package:admin_panel/screens/dashboard/activeuser/reg_user_view_mode.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RegUserScreen extends StatefulWidget {
//   const RegUserScreen({super.key});

//   @override
//   State<RegUserScreen> createState() => _RegUserScreenState();
// }

// class _RegUserScreenState extends State<RegUserScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userViewModel = Provider.of<RegUserViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('User List')),
//       body: userViewModel.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minWidth: constraints
//                                 .maxWidth, // Make table stretch full width
//                           ),
//                           child: DataTable(
//                             border: TableBorder.all(color: Colors.black12),
//                             columns: const [
//                               DataColumn(
//                                 label: Text(
//                                   'User ID',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   'Name',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   'Email',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   'Phone No',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   'Address',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               DataColumn(
//                                 label: Text(
//                                   'Country',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                             rows: userViewModel.users.map((user) {
//                               return DataRow(
//                                 cells: [
//                                   DataCell(Text(user.userId)),
//                                   DataCell(Text(user.name)),
//                                   DataCell(Text(user.email)),
//                                   DataCell(Text(user.phoneNo)),
//                                   DataCell(Text(user.address)),
//                                   DataCell(Text(user.country)),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Refresh the user list
//           Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }




// class RegUserModel {
//   final int id;
//   final String userId;
//   final String name;
//   final String email;
//   final String phoneNo;
//   final String address;
//   final String country;
//   final String image;

//   RegUserModel({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//     required this.address,
//     required this.country,
//     required this.image,
//   });

//   factory RegUserModel.fromJson(Map<String, dynamic> json) {
//     return RegUserModel(
//       id: json['id'],
//       userId: json['userid'],
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//       address: json['address'],
//       country: json['country'],
//       image: json['image'],
//     );
//   }
// }



// import 'package:admin_panel/screens/dashboard/activeuser/reg_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RegUserViewModel extends ChangeNotifier {
//   List<RegUserModel> _users = [];
//   bool _isLoading = false;

//   List<RegUserModel> get users => _users;
//   bool get isLoading => _isLoading;

//   Future<void> fetchUsers() async {
//     _isLoading = true;
//     notifyListeners();

//     final response = await http.get(
//       Uri.parse('http://84.247.161.200:9090/api/microbank/get'),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       _users = data.map((user) => RegUserModel.fromJson(user)).toList();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }



// import 'package:admin_panel/screens/dashboard/activeuser/reg_user_view_mode.dart';
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
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userViewModel = Provider.of<RegUserViewModel>(context);

//     return Scaffold(
//       body: userViewModel.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       // Table Header: Title, Search Bar, Sort Dropdown
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Screen Title
//                           const Text(
//                             'Registered Users',
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           // Search Bar
//                           Container(
//                             width: 300,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black, width: 1),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: TextField(
//                               controller: _searchController,
//                               decoration: const InputDecoration(
//                                 hintText:
//                                     'Search by User ID, Name, Email, Phone',
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 16),
//                                 border: InputBorder.none,
//                               ),
//                               onChanged: (query) {
//                                 userViewModel.searchUsers(query);
//                               },
//                             ),
//                           ),
//                           // Sort Dropdown
//                           DropdownButton<String>(
//                             value: _selectedSortOption,
//                             items: ['New', 'Old', 'Name', 'Email', 'Country']
//                                 .map((option) => DropdownMenuItem(
//                                       value: option,
//                                       child: Text(option),
//                                     ))
//                                 .toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedSortOption = value!;
//                               });
//                               userViewModel.sortUsers(value!);
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       // Data Table
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minWidth: constraints.maxWidth,
//                           ),
//                           child: DataTable(
//                             border: TableBorder.all(color: Colors.black12),
//                             columns: const [
//                               DataColumn(
//                                   label: Text('User ID',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                               DataColumn(
//                                   label: Text('Name',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                               DataColumn(
//                                   label: Text('Email',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                               DataColumn(
//                                   label: Text('Phone No',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                               DataColumn(
//                                   label: Text('Address',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                               DataColumn(
//                                   label: Text('Country',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))),
//                             ],
//                             rows: userViewModel.filteredUsers.map((user) {
//                               return DataRow(
//                                 cells: [
//                                   DataCell(Text(user.userId)),
//                                   DataCell(Text(user.name)),
//                                   DataCell(Text(user.email)),
//                                   DataCell(Text(user.phoneNo)),
//                                   DataCell(Text(user.address)),
//                                   DataCell(Text(user.country)),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
