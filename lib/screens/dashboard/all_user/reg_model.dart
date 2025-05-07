// import 'dart:convert';

// class UserRegistration {
//   final int id;
//   final String userid;
//   final String name;
//   final String email;
//   final String password;
//   final String? phoneNo;
//   final String? address;
//   final String? country; // Change from String to String?
//   final DateTime? dob;
//   final String referralCode;
//   final String? nidnumber;
//   final String? passport;
//   final bool active;
//   final String role;
//   final bool enabled;
//   final String username;
//   final List<String> authorities;
//   final bool lock;
//   final bool accountNonLocked;
//   final bool accountNonExpired;
//   final bool credentialsNonExpired;

//   UserRegistration({
//     required this.id,
//     required this.userid,
//     required this.name,
//     required this.email,
//     required this.password,
//     this.phoneNo,
//     this.address,
//     this.country, // Remove 'required' and allow null
//     this.dob,
//     required this.referralCode,
//     this.nidnumber,
//     this.passport,
//     required this.active,
//     required this.role,
//     required this.enabled,
//     required this.username,
//     required this.authorities,
//     required this.lock,
//     required this.accountNonLocked,
//     required this.accountNonExpired,
//     required this.credentialsNonExpired,
//   });

//   factory UserRegistration.fromJson(Map<String, dynamic> json) {
//     return UserRegistration(
//       id: json['id'],
//       userid: json['userid'],
//       name: json['name'],
//       email: json['email'],
//       password: json['password'],
//       phoneNo: json['phoneNo'],
//       address: json['address'],
//       country: json['country'] as String?, // Cast to String?
//       dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
//       referralCode: json['referralCode'],
//       nidnumber: json['nidnumber'],
//       passport: json['passport'],
//       active: json['active'],
//       role: json['role'],
//       enabled: json['enabled'],
//       username: json['username'],
//       authorities: (json['authorities'] as List)
//           .map((auth) => auth['authority'] as String)
//           .toList(),
//       lock: json['lock'],
//       accountNonLocked: json['accountNonLocked'],
//       accountNonExpired: json['accountNonExpired'],
//       credentialsNonExpired: json['credentialsNonExpired'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userid': userid,
//       'name': name,
//       'email': email,
//       'password': password,
//       'phoneNo': phoneNo ??
//           '', // Handle nullable phoneNo by assigning an empty string if null
//       'address': address ?? '', // Provide a fallback for nullable address
//       'country': country,
//       'dob': dob?.toIso8601String(),
//       'referralCode': referralCode,
//       'nidnumber': nidnumber,
//       'passport': passport,
//       'active': active,
//       'role': role,
//       'enabled': enabled,
//       'username': username,
//       'authorities': authorities.map((auth) => {'authority': auth}).toList(),
//       'lock': lock,
//       'accountNonLocked': accountNonLocked,
//       'accountNonExpired': accountNonExpired,
//       'credentialsNonExpired': credentialsNonExpired,
//     };
//   }

//   @override
//   String toString() {
//     return jsonEncode(toJson());
//   }
// }

import 'dart:convert';

class UserRegistration {
  final int id;
  final String userid;
  final String name;
  final String email;
  final String password;
  final String? phoneNo;
  final String? address;
  final String? country;
  final DateTime? dob;
  final String referralCode;
  final String? nidnumber;
  final String? passport;
  final bool active;
  final String role;
  final bool enabled;
  final String username;
  final List<String> authorities;
  final bool lock;
  final bool accountNonLocked;
  final bool accountNonExpired;
  final bool credentialsNonExpired;

  UserRegistration({
    required this.id,
    required this.userid,
    required this.name,
    required this.email,
    required this.password,
    this.phoneNo,
    this.address,
    this.country,
    this.dob,
    required this.referralCode,
    this.nidnumber,
    this.passport,
    required this.active,
    required this.role,
    required this.enabled,
    required this.username,
    required this.authorities,
    required this.lock,
    required this.accountNonLocked,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      id: json['id'] as int, // Non-nullable int
      userid: json['userid'] as String, // Non-nullable String
      name: json['name'] as String, // Non-nullable String
      email: json['email'] as String, // Non-nullable String
      password: json['password'] as String, // Non-nullable String
      phoneNo: json['phoneNo'] as String?, // Nullable String
      address: json['address'] as String?, // Nullable String
      country: json['country'] as String?, // Nullable String
      dob: json['dob'] != null
          ? DateTime.parse(json['dob'] as String)
          : null, // Nullable DateTime
      // Handle null for referralCode by defaulting to empty string
      referralCode: json['referralCode'] as String? ?? '',
      nidnumber: json['nidnumber'] as String?, // Nullable String
      passport: json['passport'] as String?, // Nullable String
      active: json['active'] as bool, // Non-nullable bool
      role: json['role'] as String, // Non-nullable String
      enabled: json['enabled'] as bool, // Non-nullable bool
      username: json['username'] as String, // Non-nullable String
      // Handle null authorities list and null authority values
      authorities: (json['authorities'] as List<dynamic>? ?? [])
          .map((auth) =>
              (auth as Map<String, dynamic>?)?['authority'] as String? ?? '')
          .toList(),
      lock: json['lock'] as bool, // Non-nullable bool
      accountNonLocked: json['accountNonLocked'] as bool, // Non-nullable bool
      accountNonExpired: json['accountNonExpired'] as bool, // Non-nullable bool
      credentialsNonExpired:
          json['credentialsNonExpired'] as bool, // Non-nullable bool
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'name': name,
      'email': email,
      'password': password,
      'phoneNo': phoneNo ?? '', // Default to empty string if null
      'address': address ?? '', // Default to empty string if null
      'country': country, // Nullable, no default needed
      'dob': dob?.toIso8601String(), // Nullable, handled by ?
      'referralCode': referralCode, // Non-nullable, already ensured in fromJson
      'nidnumber': nidnumber, // Nullable, no default needed
      'passport': passport, // Nullable, no default needed
      'active': active,
      'role': role,
      'enabled': enabled,
      'username': username,
      'authorities': authorities.map((auth) => {'authority': auth}).toList(),
      'lock': lock,
      'accountNonLocked': accountNonLocked,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
