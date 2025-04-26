// nominee_model.dart (Model)
class Nominee {
  final int id;
  final String name;
  final String email;
  final String cellNo;
  final DateTime dob;
  final String relationship;
  final User user;

  Nominee({
    required this.id,
    required this.name,
    required this.email,
    required this.cellNo,
    required this.dob,
    required this.relationship,
    required this.user,
  });

  factory Nominee.fromJson(Map<String, dynamic> json) {
    return Nominee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cellNo: json['cellNo'],
      dob: DateTime.parse(json['dob']),
      relationship: json['relationship'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNo;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      address: json['address'],
    );
  }
}
