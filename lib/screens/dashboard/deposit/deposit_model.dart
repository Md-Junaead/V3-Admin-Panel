class Balance {
  final int id;
  final UserRegistration userRegistration;
  final double addBalance;
  final double dipositB;
  final String packages;
  final double profitB;
  final double dipositwithdra;
  final double profitwithdra;

  Balance({
    required this.id,
    required this.userRegistration,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.dipositwithdra,
    required this.profitwithdra,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
      addBalance: json['addBalance'].toDouble(),
      dipositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      dipositwithdra: json['dipositwithdra'].toDouble(),
      profitwithdra: json['profitwithdra'].toDouble(),
    );
  }
}

class UserRegistration {
  final String userid;
  final String name;
  final String? country; // Change from String to String?

  UserRegistration({
    required this.userid,
    required this.name,
    this.country,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      userid: json['userid'],
      name: json['name'],
      country: json['country'],
    );
  }
}
