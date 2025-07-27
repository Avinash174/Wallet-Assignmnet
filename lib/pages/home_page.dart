import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/wallet_controller.dart';

class HomePage extends StatelessWidget {
  final WalletController controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wallet"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditProfileDialog(context);
            },
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "👤 Name: ${controller.name.value}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "📱 Contact: ${controller.contact.value}",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                "💰 Balance: ₹${controller.balance.value.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _showAddMoneyDialog(context),
                    child: const Text("Add Money"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _showSpendMoneyDialog(context),
                    child: const Text("Spend Money"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "🧾 Transactions:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final tx = controller.transactions[index];
                    return ListTile(
                      leading: Icon(
                        tx['type'] == 'Add'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: tx['type'] == 'Add' ? Colors.green : Colors.red,
                      ),
                      title: Text("${tx['type']} ₹${tx['amount']}"),
                      subtitle: Text("${tx['note'] ?? ''}\n${tx['date']}"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddMoneyDialog(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Money"),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter amount"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              double amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                controller.addMoney(amount);
                Get.back();
              } else {
                Get.snackbar("Error", "Enter valid amount");
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showSpendMoneyDialog(BuildContext context) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Spend Money"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter amount"),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(hintText: "Enter note"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              double amount = double.tryParse(amountController.text) ?? 0;
              String note = noteController.text.trim();
              if (amount > 0) {
                controller.spendMoney(amount, note);
                Get.back();
              } else {
                Get.snackbar("Error", "Enter valid amount");
              }
            },
            child: const Text("Spend"),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: controller.name.value);
    final contactController = TextEditingController(
      text: controller.contact.value,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Mobile Number"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final contact = contactController.text.trim();

              if (name.isEmpty || contact.isEmpty) {
                Get.snackbar("Error", "Fields cannot be empty");
              } else if (!RegExp(r'^\d{10}$').hasMatch(contact)) {
                Get.snackbar("Error", "Enter valid 10-digit mobile number");
              } else {
                controller.saveProfile(name, contact);
                Get.back();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
