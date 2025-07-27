import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/controller/wallet_controller.dart';

class SpendMoneyPage extends StatelessWidget {
  final WalletController controller = Get.find();
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spend Money")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountCtrl,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: noteCtrl,
              decoration: InputDecoration(labelText: "Note"),
            ),
            ElevatedButton(
              onPressed: () {
                final amt = double.tryParse(amountCtrl.text);
                if (amt != null && amt <= controller.balance.value) {
                  controller.spendMoney(amt, noteCtrl.text);
                  Get.back();
                }
              },
              child: Text("Spend"),
            ),
          ],
        ),
      ),
    );
  }
}
