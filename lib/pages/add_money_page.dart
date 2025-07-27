import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/controller/wallet_controller.dart';

class AddMoneyPage extends StatelessWidget {
  final WalletController controller = Get.find();
  final amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Money")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountCtrl,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final amt = double.tryParse(amountCtrl.text);
                if (amt != null) {
                  controller.addMoney(amt);
                  Get.back();
                }
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
