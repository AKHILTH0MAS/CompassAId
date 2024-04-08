import 'package:break_down_assistance/constants/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'adminUser.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
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

          final user = snapshot.data?.docs ?? [];

          return ListView.separated(
            separatorBuilder: (context,index){
              return SizedBox(height:10);
            },
            itemBuilder: (context, index) {
              // Access the data using mechanics[index].data() or mechanics[index]['fieldName']
              final name = user[index]['username'];
              final phone = user[index]['phone'];
              final email = user[index]['email'];

              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/pro.png"),
                    ),
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: $name"),
                        Text("Mobile: $phone"),
                        Text("Email: $email"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminUser(id:user[index].id)),
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: user.length,
          );
        },
      ),
    );
  }
}
