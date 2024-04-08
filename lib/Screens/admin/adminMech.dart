import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminMechanic extends StatefulWidget {
  final String id;

  const AdminMechanic({Key? key, required this.id}) : super(key: key);

  @override
  _AdminMechanicState createState() => _AdminMechanicState();
}

class _AdminMechanicState extends State<AdminMechanic> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userFuture;

  @override
  void initState() {
    super.initState();
    // Fetch user details using the provided id
    userFuture =
        FirebaseFirestore.instance.collection('mechanic').doc(widget.id).get();
  }

  void updateStatus(int newStatus) async {
    try {
      // Update the 'status' field in Firestore
      await FirebaseFirestore.instance
          .collection('mechanic')
          .doc(widget.id)
          .update({'status': newStatus});

      // rebuild of the UI by updating the status
      setState(() {
        userFuture = FirebaseFirestore.instance
            .collection('mechanic')
            .doc(widget.id)
            .get();
      });

      print('Status updated successfully');
    } catch (error) {
      print('Error updating status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40).r,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30)
                    .r,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                // Extract user data from the snapshot
                final userData = snapshot.data?.data() ?? {};

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
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
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: lightBlue,
                            child: Image.asset(
                              "assets/pro.png",
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppText(
                            text: "Name",
                            weight: FontWeight.w600,
                            size: 18,
                            textcolor: customBalck,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const AppText(
                            text: "Location",
                            weight: FontWeight.w600,
                            size: 18,
                            textcolor: customBalck,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 30,
                        ).r,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "Mechanic Username",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "name",
                              controller: TextEditingController(
                                  text: userData['username'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "Phone number",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "phone number",
                              controller: TextEditingController(
                                  text: userData['phone'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "email adders",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "email",
                              controller: TextEditingController(
                                  text: userData['email'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "work experience",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "work experience",
                              controller: TextEditingController(
                                  text: userData['experience'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "workshop name",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "workshop name",
                              controller: TextEditingController(
                                  text: userData['workshop'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: "your location",
                                weight: FontWeight.w500,
                                size: 16,
                                textcolor: customBalck,
                              ),
                            ),
                            CustomTextField(
                              hint: "your location",
                              controller: TextEditingController(
                                  text: userData['location'] ?? ''),
                              validator: (value) {
                                return null;
                              },
                              fillcolor: lightBlue,
                              readonly: true,
                            ),
                          ],
                        ),
                      ),
                      if (userData['status'] == '0')
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                btnname: "Accept",
                                btntheam: tabcolor,
                                textcolor: white,
                                click: () {
                                  updateStatus(1);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomButton(
                                btnname: "reject",
                                btntheam: lightred,
                                textcolor: white,
                                click: () {
                                  updateStatus(2);
                                },
                              ),
                            ),
                          ],
                        ),
                      if (userData['status'] ==
                          1) // Display only if status is Approved (1)
                        CustomButton(
                          btnname: "Approved",
                          btntheam: Colors.green,
                          textcolor: white,
                          click: () {
                            // Handle the action when the Approved button is clicked
                            // For example, navigate to a new screen
                          },
                        ),
                      if (userData['status'] ==
                          2) // Display only if status is Rejected (2)
                        CustomButton(
                          btnname: "Rejected",
                          btntheam: Colors.red,
                          textcolor: white,
                          click: () {
                            // Handle the action when the Rejected button is clicked
                            // For example, navigate to a new screen
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
