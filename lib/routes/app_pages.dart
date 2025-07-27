import 'package:get/get.dart';
import 'package:walletapp/pages/add_money_page.dart';
import 'package:walletapp/pages/home_page.dart';
import 'package:walletapp/pages/spend_money_page.dart';
import 'package:walletapp/pages/transaction_page.dart';
import 'package:walletapp/pages/user_profile_page.dart';

import 'package:walletapp/main.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.main, page: () => MainScreen()),
    GetPage(name: AppRoutes.home, page: () => HomePage()),
    GetPage(name: AppRoutes.addMoney, page: () => AddMoneyPage()),
    GetPage(name: AppRoutes.spendMoney, page: () => SpendMoneyPage()),
    GetPage(name: AppRoutes.transaction, page: () => TransactionPage()),
    GetPage(name: AppRoutes.userProfile, page: () => UserProfilePage()),
  ];
}
