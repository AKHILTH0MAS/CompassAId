import 'package:break_down_assistance/Screens/admin/adminHome.dart';
import 'package:break_down_assistance/Screens/admin/notification.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../widgets/customTextfield.dart';

class AddNotification extends StatefulWidget {
  AddNotification({Key? key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  final matter = TextEditingController();
  final content = TextEditingController();
  final formkey = GlobalKey<FormState>();
  DateTime dt = DateTime.now();
  String dt1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String tm1 = DateFormat('HH:mm').format(DateTime.now());


  Future<void> addNotifications() async {
    print('.........................');
    await FirebaseFirestore.instance.collection('notifications').add({
      'matter': matter.text,
      'content': content.text,
      'date': dt1,
      'time':tm1
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AdminHome();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: customBalck,
          ),
        ),
      ),
      backgroundColor: lightBlue,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20).r,
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: "Enter Matter",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Matter cannot be empty';
                      }
                      // Add more specific validation logic if needed
                      return null;
                    },
                    hint: "enter matter",
                    controller: matter,
                    fillcolor: white,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: "Enter Content",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10).r,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Matter cannot be empty';
                        }
                        // Add more specific validation logic if needed
                        return null;
                      },
                      controller: content,
                      decoration: const InputDecoration(
                        hintText: "Contents...",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                        ),
                        fillColor: white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                        ),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                      top: 60,
                      bottom: 30,
                    ).r,
                    child: CustomButton(
                      btnname: "Submit",
                      btntheam: customBlue,
                      textcolor: white,
                      click: () {
                        formkey.currentState!.validate();
                        addNotifications();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
