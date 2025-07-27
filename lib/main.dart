import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

import 'controller/wallet_controller.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/transaction_page.dart';

void main() {
  Get.put(WalletController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallet App',
        theme: controller.isDark.value ? ThemeData.dark() : ThemeData.light(),
        home: MainScreen(),
      );
    });
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), TransactionPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blueAccent,
        animationDuration: Duration(milliseconds: 300),
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.list, color: Colors.white),
            label: 'Transactions',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, color: Colors.white),
            label: 'Settings',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
