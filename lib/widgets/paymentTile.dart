import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../constants/color.dart';
import 'apptext.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    Key? key,
    required this.date,
    required this.amount,
    required this.service,
    required this.mechanicId, 
    required this.customerId,
  }) : super(key: key);

  final String date;
  final String amount;
  final String service;
  final String mechanicId;
  final String customerId;

  Future<String> _getUserName(String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      return snapshot.get('username') ?? 'Unknown';
    } else {
      return 'Unknown';
    }
  }
   Future<String> _getUserName1(String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('mechanic')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      return snapshot.get('username') ?? 'Unknown';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: Container(
        height: 125.h,
        width: double.infinity,
        color: white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               AppText(
                text: service,
                weight: FontWeight.w400,
                size: 14,
                textcolor: Colors.black,
              ),
              AppText(
                text: "₹ $amount/-",
                weight: FontWeight.w500,
                size: 14,
                textcolor: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: _getUserName(customerId),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return AppText(
                        text: 'User : ${snapshot.data}' ?? 'Unknown',
                        weight: FontWeight.w400,
                        size: 14,
                        textcolor: Colors.black,
                      );
                    },
                  ),
                  
                  AppText(
                    text: date,
                    weight: FontWeight.w400,
                    size: 14,
                    textcolor: Colors.black,
                  ),
                ],
              ),
              
             
              FutureBuilder<String>(
                future: _getUserName1(mechanicId),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return AppText(
                    text: 'Mechanic : ${snapshot.data}' ?? 'Unknown',
                    weight: FontWeight.w400,
                    size: 14,
                    textcolor: Colors.black,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
