import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/wallet_controller.dart';

class UserProfilePage extends StatelessWidget {
  final WalletController controller = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    mobileController.text.isNotEmpty) {
                  controller.saveProfile(
                    nameController.text,
                    mobileController.text,
                  );
                  Get.snackbar("Success", "Profile saved");
                  Get.back();
                } else {
                  Get.snackbar("Error", "Please enter all fields");
                }
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
