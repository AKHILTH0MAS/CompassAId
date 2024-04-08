import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/serviceTile.dart';

class Services extends StatefulWidget {
  Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final formkey = GlobalKey<FormState>();

  final service = TextEditingController();

 String mechanicId='';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20).r,
            child: const Icon(
              Icons.arrow_back_ios,
              color: customBalck,
            ),
          ),
          backgroundColor: maincolor,
          title: AppText(
              text: "Service",
              weight: FontWeight.w400,
              size: 20.sp,
              textcolor: customBalck),
          centerTitle: true),
      body: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 20).r,
          child: FutureBuilder<QuerySnapshot>(
            
              future: FirebaseFirestore.instance.collection('service').where('mech_id',isEqualTo: mechanicId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // Extract services from the snapshot
                final services = snapshot.data?.docs ?? [];
                

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return  ServiceTile(
                      title: services[index]['service'],
                      id:services[index].id,
                    );
                  },
                  itemCount: services.length,
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add(context);
        },
        shape: const CircleBorder(
          side: BorderSide(color: customBalck),
        ),
        backgroundColor: white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 350.h,
            width: 300.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: maincolor),
            child: Padding(
              padding: const EdgeInsets.all(20).r,
              child: Padding(
                padding: const EdgeInsets.all(15).r,
                child: Form(
                  key: formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                            text: "Add service",
                            weight: FontWeight.w500,
                            size: 20,
                            textcolor: customBalck),
                        Padding(
                          padding: const EdgeInsets.only(top: 40).r,
                          child: CustomTextField(
                              hint: "service",
                              controller: service,
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  // validator.........
                                  return "enter Service";
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 40)
                              .r,
                          child: CustomButton(
                              btnname: "Add",
                              btntheam: customBlue,
                              textcolor: white,
                              click: () {
                                formkey.currentState!.validate();
                                setState(() {
                                  
                                });
                                addService();
                              }),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addService() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var mech_id = spref.getString('mech_id');
    print('.........................');
    await FirebaseFirestore.instance.collection('service').add({
      'service': service.text,
      'mech_id': mech_id
    });
    service.text='';
    Navigator.pop(context);
    // username.clear();
    // phone.clear();
    // email.clear();
    // experience.clear();
    // workshop.clear();
    // password.clear();
  }
}
