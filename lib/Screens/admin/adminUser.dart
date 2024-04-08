import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminUser extends StatefulWidget {
  String id;
  AdminUser({super.key, required this.id});

  @override
  State<AdminUser> createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
    late Future<DocumentSnapshot<Map<String, dynamic>>> userFuture;



   @override
  void initState() {
    super.initState();
    // Fetch user details using the provided id
    userFuture = FirebaseFirestore.instance.collection('users').doc(widget.id).get();
  }
      void updateStatus(int newStatus) async {
  try {
    // Update the 'status' field in Firestore
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.id)
        .update({'status': newStatus});

    // Trigger a rebuild of the UI by updating the userFuture
    setState(() {
      userFuture = FirebaseFirestore.instance.collection('users').doc(widget.id).get();
    });

    // Display a success message or perform additional actions
    print('Status updated successfully');
  } catch (error) {
    // Handle errors, e.g., display an error message
    print('Error updating status: $error');
  }
}
  @override
  final username = TextEditingController();

  final phone = TextEditingController();

  final email = TextEditingController();

  final location = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40).r,
        child: FutureBuilder(
          future: userFuture,
          builder: (context,snapshot) {
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

                // Extract user data from the snapshot
                final userData = snapshot.data?.data() ?? {};
            return Container(
                height: double.infinity,
                width: double.infinity,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 30)
                      .r,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                    ))),
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
                            Text(userData['username'],style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600),),
                            Text(userData['location'],style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600),),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30).r,
                          child: Column(
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppText(
                                      text: "Username",
                                      weight: FontWeight.w500,
                                      size: 16,
                                      textcolor: customBalck)),
                              CustomTextField(
                                hint: "name",
                                controller: TextEditingController(text: userData['username'] ?? ''),
                                validator: (value) {},
                                fillcolor: lightBlue,
                                readonly: true,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppText(
                                      text: "Phone number",
                                      weight: FontWeight.w500,
                                      size: 16,
                                      textcolor: customBalck)),
                              CustomTextField(
                                hint: "phone number",
                                controller: TextEditingController(text: userData['phone'] ?? ''),
                                validator: (value) {},
                                fillcolor: lightBlue,
                                readonly: true,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppText(
                                      text: "email adders",
                                      weight: FontWeight.w500,
                                      size: 16,
                                      textcolor: customBalck)),
                              CustomTextField(
                                hint: "email",
                                controller: TextEditingController(text: userData['email'] ?? ''),
                                validator: (value) {},
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
                          SizedBox(
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
                       if (userData['status'] == 1) // Display only if status is Approved (1)
                        CustomButton(
                          btnname: "Approved",
                          btntheam: Colors.green,
                          textcolor: white,
                          click: () {
                            // Handle the action when the Approved button is clicked
                            // For example, navigate to a new screen
                          },
                        ),
                      if (userData['status'] == 2) // Display only if status is Rejected (2)
                        CustomButton(
                          btnname: "Rejected",
                          btntheam: Colors.red,
                          textcolor: white,
                          click: () {
                            // Handle the action when the Rejected button is clicked
                            // For example, navigate to a new screen
                          },
                        ),

                      ]),
                ));
          }
        ),
      ),
    );
  }
}
