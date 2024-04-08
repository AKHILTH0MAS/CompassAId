import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/acceptTile.dart';

class AcceptedList extends StatefulWidget {
  const AcceptedList({super.key});

  @override
  State<AcceptedList> createState() => _AcceptedListState();
}

class _AcceptedListState extends State<AcceptedList> {
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
  SharedPreferences spref = await SharedPreferences.getInstance();
  var mechId = spref.getString('mech_id');
  print('............$mechId');

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('mechrequest')
            .where('mech_id', isEqualTo: mechId).where('status', whereIn: ['1', '3', '5', '4'])
            .get();

    print('Firestore Data: ${querySnapshot.docs}');
    
    return querySnapshot;
  } catch (e) {
    print('Error fetching data: $e');
    throw e; // Rethrow the exception to be caught by the FutureBuilder
  }
}


  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body:
        FutureBuilder(future: getData(),

          builder: (context, snapshot) {
        print('---------------${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
          // return Text('data');
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Extract requests from the snapshot
        final requests = snapshot.data?.docs ?? [];
            return ListView.builder(
                  itemBuilder: (context, index) {
        var request = requests[index].data() as Map<String, dynamic>;

            print('>>>>>>>>>>>>>$request');
            return AcceptTile(
              image: "assets/men.png",
              name: "",
              issue: request['issue'] ?? "Unknown",
              date: request['date'] ?? "Unknown",
              time: request['time'] ?? "Unknown",
              place: request['place'] ?? "Unknown",
              status: request['status'] ?? "unknown", 
              r_id: requests[index].id
              // if status is true payment success/else payment is pending.....
            );
                  },
                  itemCount: requests.length,
                );
          }
        );
    //);
  }
}
