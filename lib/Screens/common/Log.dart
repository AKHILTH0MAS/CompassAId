import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../admin/adminLogin.dart';
import '../mecanic/Login.dart';
import '../user/UserLogin.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool selectedOption = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: maincolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45, top: 100).r,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            "assets/logo.png",
            width: 140.w,
            height: 140.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: AppText(
                text: "who you are",
                weight: FontWeight.w700,
                size: 16,
                textcolor: customBalck),
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomButton(
              btnname: "Mechanic",
              btntheam: selectedOption == true ? customBlue : white,
              textcolor: selectedOption == true ? white : customBalck,
              click: () {
                setState(() {
                  selectedOption = true;
                });
              }),
          SizedBox(
            height: 40.h,
          ),
          CustomButton(
              btnname: "User",
              btntheam: selectedOption == false ? customBlue : white,
              textcolor: selectedOption == false ? white : customBalck,
              click: () {
                setState(() {
                  selectedOption = false;
                });
              }),
          SizedBox(
            height: 40.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AdminLogin(), // goto admin login screen...
                  ));
            },
            child: const AppText(
                text: "Admin Login",
                weight: FontWeight.w600,
                size: 22,
                textcolor: customBlue),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 140).r,
            child: CustomButton(
                btnname: "CONTINUE",
                btntheam: customBlue,
                textcolor: white,
                click: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => selectedOption == true
                              ? MechLogin() //go to mechanic login screen...
                              : UserLogin() // go to user login screen...
                          ));
                }),
          ),
        ]),
      ),
    );
  }
}
