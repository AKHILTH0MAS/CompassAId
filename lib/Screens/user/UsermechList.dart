import 'package:break_down_assistance/widgets/mecanicStatusTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ServiceScreen.dart';

class UserMecList extends StatelessWidget {
  final Stream<QuerySnapshot> stream;

  const UserMecList({required this.stream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 34, right: 34).r,
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            var mechanics = snapshot.data!.docs;

            return ListView.builder(
              itemCount: mechanics.length,
              itemBuilder: (context, index) {
                var mechanic = mechanics[index].data() as Map<String, dynamic>;

                return MechanicStatusTile(
                  image: "assets/men3.png",
                  name: '',
                  experience: mechanic['username'] ?? "Experience not available",
                  work: mechanic['service'] ?? "Work not available",
                  status: true, // Change this to get the actual status
                  click: () {
                    // Pass relevant data to the ServiceScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceScreen(
                          name: mechanic['username'],
                          exp: mechanic['experience'],
                          mob: mechanic['phone'],
                          mech: mechanics[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
