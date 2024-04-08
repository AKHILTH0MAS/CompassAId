import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/apptext.dart';
import '../../widgets/customTextfield.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // final username = TextEditingController();

  // final phone = TextEditingController();

  // final email = TextEditingController();

  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController experience;
  late TextEditingController location;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    experience = TextEditingController();
    location = TextEditingController();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      username.text = spref.getString('name') ?? '';
      phone.text = spref.getString('phone') ?? '';
      email.text = spref.getString('email') ?? '';
      location.text = spref.getString('location') ?? '';
      experience.text = spref.getString('exp') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).r,
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                "assets/men.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30).r,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: AppText(
                    text: "Enter Username",
                    weight: FontWeight.w500,
                    size: 16.sp,
                    textcolor: customBalck),
              ),
            ),
            CustomTextField(
                hint: "Enter Username",
                fillcolor: lightBlue,
                controller: username,
                validator: (value) {}),
            Align(
              alignment: Alignment.bottomLeft,
              child: AppText(
                  text: "Enter Phone number",
                  weight: FontWeight.w500,
                  size: 16.sp,
                  textcolor: customBalck),
            ),
            CustomTextField(
                hint: "Enter Phone number",
                fillcolor: lightBlue,
                controller: phone,
                kebordtype: TextInputType.number,
                validator: (value) {}),
            Align(
              alignment: Alignment.bottomLeft,
              child: AppText(
                  text: "Enter your email",
                  weight: FontWeight.w500,
                  size: 16.sp,
                  textcolor: customBalck),
            ),
            CustomTextField(
                hint: "Enter your email",
                fillcolor: lightBlue,
                controller: email,
                kebordtype: TextInputType.emailAddress,
                validator: (value) {}),
            Align(
              alignment: Alignment.bottomLeft,
              child: AppText(
                  text: "Enter your work experience",
                  weight: FontWeight.w500,
                  size: 16.sp,
                  textcolor: customBalck),
            ),
            CustomTextField(
                hint: "Enter your work experience",
                fillcolor: lightBlue,
                controller: experience,
                validator: (value) {}),
            Align(
              alignment: Alignment.bottomLeft,
              child: AppText(
                  text: "Enter your location",
                  weight: FontWeight.w500,
                  size: 16.sp,
                  textcolor: customBalck),
            ),
            CustomTextField(
                hint: "Enter your location",
                fillcolor: lightBlue,
                controller: location,
                validator: (value) {}),
            Padding(
              padding: const EdgeInsets.only(
                      top: 30, left: 40, right: 40, bottom: 50)
                  .r,
              child: CustomButton(
                  btnname: "Submit",
                  btntheam: customBlue,
                  textcolor: white,
                  click: () async {
                    SharedPreferences spref =
                        await SharedPreferences.getInstance();
                    var id = spref.getString('mech_id');
                    FirebaseFirestore.instance
                        .collection('mechanic')
                        .doc(id)
                        .update({
                      'username': username.text,
                      'phone': phone.text,
                      'email': email.text,
                      'experience': experience.text,
                      'location': location.text
                    }).then((value) async {
                      // Successfully updated
                      Navigator.pop(context);
                      SharedPreferences spref =
                          await SharedPreferences.getInstance();
                      setState(() {
                        spref.setString('name', username.text) ?? '';
                        spref.setString('phone', phone.text) ?? '';
                        spref.setString('email', email.text) ?? '';
                        spref.setString('location', location.text) ?? '';
                        spref.setString('exp', experience.text) ?? '';
                      });
                    }).catchError((error) {
                      print('Error updating user information: $error');
                      // Handle error, show a message, etc.
                    });
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
