import 'package:break_down_assistance/Screens/common/Log.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePassword extends StatefulWidget {
  String id;
  UpdatePassword({super.key, required this.id});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Padding(
        padding: EdgeInsets.only(left: 45, right: 45, top: 10).r,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: AppText(
                  text: "Enter New password",
                  weight: FontWeight.w500,
                  size: 16,
                  textcolor: customBalck,
                ),
              ),
              CustomTextField(
                hint: "Password",
                controller: passwordController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter New Password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print(widget.id);
                      await FirebaseFirestore.instance
                          .collection('mechanic')
                          .doc(widget.id)
                          .update({
                        'password': passwordController.text,
                      });

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return Login();
                      }));
                    },
                    child: const AppText(
                        text: "Update Password",
                        weight: FontWeight.w400,
                        size: 13,
                        textcolor: Color.fromARGB(255, 4, 58, 103)),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
