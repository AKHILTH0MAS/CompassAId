import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/requestTile.dart';
import 'RequestScreen.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({ Key? key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var mechId = spref.getString('mech_id');
    print('............$mechId');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('mechrequest')
              .where('mech_id', isEqualTo: mechId)
              .where('status', isEqualTo: '0')
              .get();

      print('Firestore Data: ${querySnapshot.docs}');

      return querySnapshot;
    } catch (e) {
      print('Error fetching data: $e');
      rethrow; // Rethrow the exception to be caught by the FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        print('---------------${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          // return Text('data');
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Extract requests from the snapshot
        final requests = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemBuilder: (context, index) {
            // Access dynamic data from Firestore query
            // print('object');
            var request = requests[index].data();
            var id = requests[index].id;
            print('>>>>>>>>>>>>>$id');

            return RequestTile(
              image: "assets/men.png",
              name: '' ?? "Unknown",
              issue: request['issue'] ?? "Unknown",
              date: request['date'] ?? "Unknown",
              time: request['time'] ?? "Unknown",
              place: request['place'] ?? "Unknown",
              click: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestScreen(
                      req_id: id,
                      name: request['name'] ?? "Unknown",
                      issue: request['issue'] ?? "Unknown",
                      place: request['place'] ?? "Unknown",
                      date: request['date'] ?? "Unknown",
                      time: request['time'] ?? "Unknown",
                      status: request['status'] ?? "unknown",
                      vehicleDetails: request['note'] ?? "unknown",
                    ),
                  ),
                );
              },
            );
          },
          itemCount: requests.length,
        );
      },
    );
  }
}
