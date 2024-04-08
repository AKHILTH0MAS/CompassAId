import 'package:break_down_assistance/constants/color.dart';
import 'package:flutter/material.dart';

import 'MechMain.dart';
import 'Rating.dart';
import 'Service.dart';

class MechHome extends StatefulWidget {
  MechHome({super.key});

  @override
  State<MechHome> createState() => _MechHomeState();
}

class _MechHomeState extends State<MechHome> {
  int Index = 0;

  List pages = [MechMain(), Services(), Rating()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[Index],
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.engineering), label: "Request"),
            BottomNavigationBarItem(
                icon: Icon(Icons.handyman), label: "Service"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Rating")
          ],
          currentIndex: Index,
          onTap: (newIndex) {
            setState(() {
              Index = newIndex;
            });
          },
          selectedItemColor: tabcolor,
          unselectedItemColor: customBalck),
    );
  }
}
