import 'package:break_down_assistance/Screens/admin/adminLogin.dart';
import 'package:break_down_assistance/Screens/common/Log.dart';
import 'package:break_down_assistance/widgets/notificationTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';
import 'addNotification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                  actions: [IconButton(onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
              return Login();
            }));
                  }, icon: Icon(Icons.logout_rounded))],

      ),
      backgroundColor: lightBlue,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20).r,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('notifications').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final notification = snapshot.data?.docs ?? [];

            return ListView.builder(
              
              itemBuilder: (context, index) {
                  
                return  NotificationTile(
                    heading: notification[index]['matter'],
                    contents:notification[index]['content']
                        );
              },
              itemCount: notification.length,
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotification(),
                ));
          },
          backgroundColor: white,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: customBlue,
            size: 35,
          )),
    );
  }
}
