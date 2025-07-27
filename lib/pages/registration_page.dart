import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/controller/wallet_controller.dart';
import 'home_page.dart';

class RegistrationPage extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: mobileCtrl,
              decoration: InputDecoration(labelText: "Mobile"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.registerUser(nameCtrl.text, mobileCtrl.text);
                Get.offAll(() => HomePage());
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
