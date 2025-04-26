import 'dart:convert';

List<LoanModel> loanModelFromJson(String str) =>
    List<LoanModel>.from(json.decode(str).map((x) => LoanModel.fromJson(x)));

String loanModelToJson(List<LoanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanModel {
  int id;
  double eligeblebalancey;
  double loanamuont;
  double weeklypay;
  double totalpay;
  int tenure;
  String status;
  DateTime requestdate;
  UserRegistration userRegistration;
  Balance? balance;

  LoanModel({
    required this.id,
    required this.eligeblebalancey,
    required this.loanamuont,
    required this.weeklypay,
    required this.totalpay,
    required this.tenure,
    required this.status,
    required this.requestdate,
    required this.userRegistration,
    this.balance,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) => LoanModel(
        id: json["id"],
        eligeblebalancey: json["eligeblebalancey"].toDouble(),
        loanamuont: json["loanamuont"].toDouble(),
        weeklypay: json["weeklypay"].toDouble(),
        totalpay: json["totalpay"].toDouble(),
        tenure: json["tenure"],
        status: json["status"],
        requestdate: DateTime.parse(json["requestdate"]),
        userRegistration: UserRegistration.fromJson(json["userRegistration"]),
        balance:
            json["balance"] == null ? null : Balance.fromJson(json["balance"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eligeblebalancey": eligeblebalancey,
        "loanamuont": loanamuont,
        "weeklypay": weeklypay,
        "totalpay": totalpay,
        "tenure": tenure,
        "status": status,
        "requestdate": requestdate.toIso8601String(),
        "userRegistration": userRegistration.toJson(),
        "balance": balance?.toJson(),
      };
}

class UserRegistration {
  int id;
  String userid;
  String name;
  String email;
  String password;
  String? phoneNo;
  String? address;
  final String? country; // Change from String to String?
  DateTime? dob;
  String referralCode;
  String? nidnumber;
  String? passport;
  bool active;
  String role;
  bool enabled;
  String username;
  List<Authority> authorities;
  bool lock;
  bool accountNonLocked;
  bool accountNonExpired;
  bool credentialsNonExpired;

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

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      UserRegistration(
        id: json["id"],
        userid: json["userid"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phoneNo"],
        address: json["address"],
        country: json["country"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        referralCode: json["referralCode"],
        nidnumber: json["nidnumber"],
        passport: json["passport"],
        active: json["active"],
        role: json["role"],
        enabled: json["enabled"],
        username: json["username"],
        authorities: List<Authority>.from(
            json["authorities"].map((x) => Authority.fromJson(x))),
        lock: json["lock"],
        accountNonLocked: json["accountNonLocked"],
        accountNonExpired: json["accountNonExpired"],
        credentialsNonExpired: json["credentialsNonExpired"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "name": name,
        "email": email,
        "password": password,
        "phoneNo": phoneNo,
        "address": address,
        "country": country,
        "dob": dob?.toIso8601String(),
        "referralCode": referralCode,
        "nidnumber": nidnumber,
        "passport": passport,
        "active": active,
        "role": role,
        "enabled": enabled,
        "username": username,
        "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
        "lock": lock,
        "accountNonLocked": accountNonLocked,
        "accountNonExpired": accountNonExpired,
        "credentialsNonExpired": credentialsNonExpired,
      };
}

class Authority {
  String authority;

  Authority({required this.authority});

  factory Authority.fromJson(Map<String, dynamic> json) =>
      Authority(authority: json["authority"]);

  Map<String, dynamic> toJson() => {
        "authority": authority,
      };
}

class Balance {
  int id;
  double addBalance;
  double dipositB;
  String packages;
  double profitB;
  double referralB;
  double dipositwithdra;
  double profitwithdra;
  DateTime date;
  String status;
  bool active;
  UserRegistration userRegistration;

  Balance({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.dipositwithdra,
    required this.profitwithdra,
    required this.date,
    required this.status,
    required this.active,
    required this.userRegistration,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        id: json["id"],
        addBalance: json["addBalance"].toDouble(),
        dipositB: json["dipositB"].toDouble(),
        packages: json["packages"],
        profitB: json["profitB"].toDouble(),
        referralB: json["referralB"].toDouble(),
        dipositwithdra: json["dipositwithdra"].toDouble(),
        profitwithdra: json["profitwithdra"].toDouble(),
        date: DateTime.parse(json["date"]),
        status: json["status"],
        active: json["active"],
        userRegistration: UserRegistration.fromJson(json["userRegistration"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addBalance": addBalance,
        "dipositB": dipositB,
        "packages": packages,
        "profitB": profitB,
        "referralB": referralB,
        "dipositwithdra": dipositwithdra,
        "profitwithdra": profitwithdra,
        "date": date.toIso8601String(),
        "status": status,
        "active": active,
        "userRegistration": userRegistration.toJson(),
      };
}
