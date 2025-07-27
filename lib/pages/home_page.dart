import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/controller/wallet_controller.dart';
import 'add_money_page.dart';
import 'spend_money_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  final WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet - ${controller.name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Get.to(() => SettingsPage()),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Obx(
            () => Text(
              "Balance: ₹${controller.balance.value}",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Get.to(() => AddMoneyPage()),
                child: Text("Add Money"),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => SpendMoneyPage()),
                child: Text("Spend Money"),
              ),
            ],
          ),
          Divider(),
          Obx(
            () => Expanded(
              child: controller.transactions.isEmpty
                  ? Center(child: Text("No transactions"))
                  : ListView.builder(
                      itemCount: controller.transactions.length,
                      itemBuilder: (_, i) {
                        final t = controller.transactions[i];
                        return ListTile(
                          title: Text("${t.type}: ₹${t.amount}"),
                          subtitle: Text("${t.date} ${t.note ?? ''}"),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
