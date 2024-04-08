import 'package:break_down_assistance/widgets/notificationCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';
import '../../widgets/apptext.dart';

class AdminNotification extends StatelessWidget {
  const AdminNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10).r,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: customBalck,
            ),
          ),
        ),
        backgroundColor: maincolor,
        title: AppText(
          text: "Notification",
          weight: FontWeight.w400,
          size: 20.sp,
          textcolor: customBalck,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30).r,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator while data is being fetched
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            var notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];
                var title = notification['matter'] ?? '';
                var content = notification['content'] ?? '';
                var date = notification['date'] ?? '';
                var time = notification['time'] ?? '';
                // Assuming you store the time in 'date' field
                // You may need to adjust this based on your Firestore structure

                return NotifiactionCard(
                  title: title,
                  time: time,
                  date: date,
                  content:content // Add the actual date field if available
                );
              },
            );
          },
        ),
      ),
    );
  }
}