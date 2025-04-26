import 'package:admin_panel/configs/routes/routes_name.dart';
import 'package:admin_panel/screens/dashboard/all_user/reg_user_screen.dart';
import 'package:admin_panel/screens/dashboard/active_user/all_user.dart';
import 'package:admin_panel/screens/dashboard/withdraw/bank_withdraw.dart';
import 'package:admin_panel/screens/dashboard/withdraw/crypto_withdraw.dart';
import 'package:admin_panel/screens/dashboard/loan/emi.dart';
import 'package:admin_panel/screens/dashboard/inactive_user/inactive_user.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_screen.dart';
import 'package:admin_panel/screens/dashboard/deposit/deposit_screen.dart';
import 'package:admin_panel/screens/login/login_screen.dart';
import 'package:admin_panel/screens/sidebar/dashboard_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //VerticalMenu routes

      case RoutesName.allUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AllUser());

      case RoutesName.regUserScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => RegUserScreen());

      case RoutesName.inactiveUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const InactiveUser());

      case RoutesName.depositScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DepositScreen());

      case RoutesName.bankWithdraw:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BankWithdraw());

      case RoutesName.cryptoWithdraw:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CryptoWithdraw());

      case RoutesName.loanScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoanScreen());

      case RoutesName.emiScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EmiScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.dashboardView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
