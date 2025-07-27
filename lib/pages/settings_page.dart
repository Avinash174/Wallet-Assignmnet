import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/controller/wallet_controller.dart';

class SettingsPage extends StatelessWidget {
  final WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Obx(
            () => SwitchListTile(
              title: Text("Dark Theme"),
              value: controller.isDark.value,
              onChanged: (val) => controller.toggleTheme(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearTransactions();
              Get.snackbar("Success", "Transactions cleared");
            },
            child: Text("Clear Transaction History"),
          ),
        ],
      ),
    );
  }
}
