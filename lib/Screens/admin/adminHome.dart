import 'package:break_down_assistance/Screens/admin/payment.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:flutter/material.dart';

import 'adminMain.dart';
import 'notification.dart';

class AdminHome extends StatefulWidget {
  AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List pages = [
    const AdminMain(),
    const PaymentScreen(),
    const NotificationScreen()
  ];

  int Index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[Index],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Payment"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Notification"),
        ],
        currentIndex: Index,
        onTap: (newIndex) {
          setState(() {
            Index = newIndex;
          });
        },
        selectedItemColor: customBlue,
        unselectedItemColor: customBalck,
      ),
    );
  }
}
