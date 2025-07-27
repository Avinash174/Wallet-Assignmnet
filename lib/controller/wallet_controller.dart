import 'package:get/get.dart';
import 'package:walletapp/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WalletController extends GetxController {
  var name = ''.obs;
  var mobile = ''.obs;
  var balance = 0.0.obs;
  var transactions = <TransactionModel>[].obs;
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void registerUser(String userName, String userMobile) async {
    name.value = userName;
    mobile.value = userMobile;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode({
      'name': userName,
      'mobile': userMobile,
    }));
  }

  void addMoney(double amount) {
    balance.value += amount;
    transactions.insert(0, TransactionModel(
      date: DateTime.now(),
      type: 'Add',
      amount: amount,
    ));
    saveTransactions();
  }

  void spendMoney(double amount, String note) {
    if (amount <= balance.value) {
      balance.value -= amount;
      transactions.insert(0, TransactionModel(
        date: DateTime.now(),
        type: 'Spend',
        amount: amount,
        note: note,
      ));
      saveTransactions();
    }
  }

  void clearTransactions() async {
    transactions.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('transactions');
  }

  void toggleTheme() => isDark.value = !isDark.value;

  void saveTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = transactions.map((e) => e.toJson()).toList();
    await prefs.setString('transactions', jsonEncode(list));
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final map = jsonDecode(user);
      name.value = map['name'];
      mobile.value = map['mobile'];
    }

    final trans = prefs.getString('transactions');
    if (trans != null) {
      final list = jsonDecode(trans);
      transactions.value = List<TransactionModel>.from(
        list.map((x) => TransactionModel.fromJson(x)),
      );
    }
  }
}
