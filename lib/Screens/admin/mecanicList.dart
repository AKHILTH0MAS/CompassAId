import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/mecahnicTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'adminMech.dart';

class MechanicList extends StatelessWidget {
  const MechanicList({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('mechanic').get(),
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

          final mechanics = snapshot.data?.docs ?? [];

          return ListView.separated(
            separatorBuilder: (context,index){
              return SizedBox(height:10);
            },
            itemBuilder: (context, index) {
              // Access the data using mechanics[index].data() or mechanics[index]['fieldName']
              final name = mechanics[index]['username'];
               final location = mechanics[index]['location'];
              final phone = mechanics[index]['phone'];
              final email = mechanics[index]['email'];

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
                        Text("Location: $location"),
                        Text("Mobile: $phone"),
                        Text("Email: $email"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminMechanic(id:mechanics[index].id)),
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: mechanics.length,
          );
        },
      ),
    );
  }
}
