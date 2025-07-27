import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  var name = ''.obs;
  var contact = ''.obs;

  var balance = 0.0.obs;
  var transactions = <Map<String, dynamic>>[].obs;
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // Save user profile to shared preferences
  void saveProfile(String username, String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', username);
    await prefs.setString('contact', mobile);
    name.value = username;
    contact.value = mobile;
  }

  // Load user profile from shared preferences
  void loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    contact.value = prefs.getString('contact') ?? '';
  }

  // Register user with validation
  void registerUser(String username, String mobile) {
    if (username.trim().isEmpty || username.length < 3) {
      Get.snackbar("Error", "Please enter a valid name");
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      Get.snackbar("Error", "Mobile number must be 10 digits");
      return;
    }

    saveProfile(username, mobile);
    Get.back();
    Get.snackbar("Success", "User profile saved");
  }

  // Add money to wallet
  void addMoney(double amount) {
    balance.value += amount;
    transactions.add({
      'type': 'Add',
      'amount': amount,
      'note': '',
      'date': DateTime.now().toString(),
    });
  }

  // Spend money from wallet
  void spendMoney(double amount, String note) {
    if (amount <= balance.value) {
      balance.value -= amount;
      transactions.add({
        'type': 'Spend',
        'amount': amount,
        'note': note,
        'date': DateTime.now().toString(),
      });
    } else {
      Get.snackbar("Insufficient Balance", "You don't have enough funds");
    }
  }

  // Clear transaction history
  void clearTransactions() {
    transactions.clear();
  }

  // Toggle dark/light theme
  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}
