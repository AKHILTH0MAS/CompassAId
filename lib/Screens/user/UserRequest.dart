import 'package:break_down_assistance/widgets/userRequestTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRequest extends StatefulWidget {
  const UserRequest({Key? key});

  @override
  State<UserRequest> createState() => _UserRequestState();
}
class _UserRequestState extends State<UserRequest> {
  late Future<List<DocumentSnapshot>> futureRequests;

  @override
  void initState() {
    super.initState();
    futureRequests = fetchRequests();
  }

  Future<List<DocumentSnapshot>> fetchRequests() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var id = spref.getString('user_id') ?? '';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>$id');

    // Fetch requests once and return the list of documents
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('mechrequest')
        .where('customer_id', isEqualTo: id)
        .get();
    
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 34),
      child: FutureBuilder<List<DocumentSnapshot>>(
        future: futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var requests = snapshot.data ?? [];

          return ListView.builder(
            itemBuilder: (context, index) {
              var request = requests[index].data() as Map<String, dynamic>;

              return UserRequestTile(
                mech_id: request['mech_id'] ?? "Unknown",
                date: request['date'] ?? "",
                time: request['time'] ?? "",
                issue: request['issue'] ?? "",
                status: request['status'] ?? "",
                amount: request['amount'] ?? "",
                r_id: requests[index].id,
                reason: request['reason'] ?? "",
              );
            },
            itemCount: requests.length,
          );
        },
      ),
    );
  }
}
