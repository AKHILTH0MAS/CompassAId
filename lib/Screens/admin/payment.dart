import 'package:break_down_assistance/Screens/admin/adminLogin.dart';
import 'package:break_down_assistance/Screens/common/Log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';
import '../../widgets/paymentTile.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Future<QuerySnapshot<Map<String, dynamic>>> paymentFuture;

  @override
  void initState() {
    super.initState();
    // Fetch documents from the 'mecrequest' collection
    paymentFuture =
        FirebaseFirestore.instance.collection('mechrequest').get();
        print(paymentFuture);
  }

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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30).r,
        child: FutureBuilder(
          future: paymentFuture,
          builder: (context, snapshot) {
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

            // Extract documents from the snapshot
            final docs = snapshot.data?.docs ?? [];
            print(docs);

            return ListView.builder(
              itemBuilder: (context, index) {
                // Extract data from each document
                final payData = docs[index].data() as Map<String, dynamic>;

                return PaymentTile(
                  customerId: payData['customer_id']??'',
                  date: payData['date'],
                  amount: payData['amount']??'',
                  service: payData['issue']??'',
                  mechanicId: payData['mech_id']??"",
                  // mechanic_name: '',
                );
              },
              itemCount: docs.length,
            );
          },
        ),
      ),
    );
  }
}
