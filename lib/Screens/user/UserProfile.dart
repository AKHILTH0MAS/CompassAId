import 'package:flutter/material.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name.text = spref.getString('name') ?? '';
      phone.text = spref.getString('phone') ?? '';
      email.text = spref.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Icon(
                Icons.account_circle_outlined,
                size: 60,
              ),
              SizedBox(height: 10.h),
              AppText(
                text: name.text,
                weight: FontWeight.w500,
                size: 10,
                textcolor: Colors.black,
              ),
              SizedBox(height: 50.h),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: "Enter your Name",
                  weight: FontWeight.w400,
                  size: 14,
                  textcolor: Colors.black,
                ),
              ),
              CustomTextField(
                hint: "Name",
                fillcolor: maincolor,
                controller: name,
                validator: (value) {},
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: "Enter your phone number",
                  weight: FontWeight.w400,
                  size: 14,
                  textcolor: Colors.black,
                ),
              ),
              CustomTextField(
                hint: "phone number",
                fillcolor: maincolor,
                controller: phone,
                validator: (value) {},
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: "Enter your email",
                  weight: FontWeight.w400,
                  size: 14,
                  textcolor: Colors.black,
                ),
              ),
              CustomTextField(
                hint: "email",
                fillcolor: maincolor,
                controller: email,
                validator: (value) {},
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 50, right: 50, top: 150).r,
                child: CustomButton(
                  btnname: "Done",
                  btntheam: customBlue,
                  textcolor: white,
                  click: () async {
                    SharedPreferences spref =
                        await SharedPreferences.getInstance();
                    var id = spref.getString('user_id');
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .update({
                      'username': name.text,
                      'phone': phone.text,
                      'email': email.text,
                    }).then((value) async {
                      // Successfully updated
                      Navigator.pop(context);
                       SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      spref.setString('name',name.text) ?? '';
      spref.setString('phone',phone.text) ?? '';
      spref.setString('email',email.text) ?? '';
    });

                    }).catchError((error) {
                      print('Error updating user information: $error');
                      // Handle error, show a message, etc.
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
