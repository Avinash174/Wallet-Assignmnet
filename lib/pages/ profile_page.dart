import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    mobileController.text = prefs.getString('mobile') ?? '';
  }

  void saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('mobile', mobileController.text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Profile Saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveProfile, child: Text('Save Profile')),
          ],
        ),
      ),
    );
  }
}
