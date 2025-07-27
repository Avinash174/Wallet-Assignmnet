import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:walletapp/controller/wallet_controller.dart';

class TransactionPage extends StatelessWidget {
  final WalletController controller = Get.find();
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              if (controller.transactions.isNotEmpty) {
                controller.clearTransactions();
                Get.snackbar(
                  'Success',
                  'All transactions cleared!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.8),
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  'Info',
                  'No transactions to clear.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.transactions.isEmpty
            ? Center(child: Text('No transactions yet.'))
            : ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (_, index) {
                  final tx = controller.transactions[index];
                  return ListTile(
                    title: Text("${tx.type} ₹${tx.amount}"),
                    subtitle: Text(
                      "${dateFormat.format(tx.date)} | ${tx.note}",
                    ),
                  );
                },
              ),
      ),
    );
  }
}
