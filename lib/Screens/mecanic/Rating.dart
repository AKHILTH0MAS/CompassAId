import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color.dart';
import '../../widgets/apptext.dart';
import '../../widgets/ratingTile.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late String mechanicId;

  @override
  void initState() {
    super.initState();
    // Fetch mechanic ID from shared preferences when the page initializes
    getMechanicIdFromSharedPreferences();
  }

  Future<void> getMechanicIdFromSharedPreferences() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      mechanicId = spref.getString('mech_id') ?? '';
    });
  }

  Future<List<Map<String, dynamic>>> getRatings() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('rating').where('mech_id', isEqualTo: mechanicId).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<String?> getCustomerName(String customerId) async {
    try {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(customerId)
          .get();

      if (customerSnapshot.exists) {
        return customerSnapshot['username'];
      }
    } catch (error) {
      print('Error fetching customer details: $error');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(
            Icons.arrow_back_ios,
            color: customBalck,
          ),
        ),
        backgroundColor: maincolor,
        title: const AppText(
          text: "Rating",
          weight: FontWeight.w400,
          size: 20,
          textcolor: customBalck,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText(
              text: "The rating given to you",
              weight: FontWeight.w400,
              size: 10,
              textcolor: Colors.grey,
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getRatings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<Map<String, dynamic>> ratings = snapshot.data!;
                  List<Future<String?>> customerNames = ratings.map((ratingData) {
                    return getCustomerName(ratingData['user_id'].toString());
                  }).toList();

                  return ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<String?>(
                        future: customerNames[index],
                        builder: (context, customerSnapshot) {
                          if (customerSnapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox();
                          }

                          String customerName = customerSnapshot.data ?? 'Unknown Customer';
                          var ratingData = ratings[index];

                          return RatingTile(
                            image: "assets/men.png",
                            name: customerName,
                            work: ratingData['rating'].toString(),
                            date: ratingData['feedback'].toString(),
                            time: '',
                            place: '',
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
