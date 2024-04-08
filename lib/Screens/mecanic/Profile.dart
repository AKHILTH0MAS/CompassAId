import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../widgets/customTextfield.dart';
import 'EditProfile.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final username = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final experience = TextEditingController();
  final workshop = TextEditingController();
  final location = TextEditingController();

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20).r,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return EditProfile();
                  },
                ));
              },
              child: const Icon(
                Icons.edit_note_outlined,
                color: customBalck,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
             CircleAvatar(
              radius: 50.r,
              backgroundImage: AssetImage(
                "assets/men.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50).r,
              child: CustomTextField(
                hint: "Enter Username",
                fillcolor: lightBlue,
                controller: username,
                validator: (value) {},
                readonly: true,
              ),
            ),
            CustomTextField(
              hint: "Enter Phone number",
              fillcolor: lightBlue,
              controller: phone,
              kebordtype: TextInputType.number,
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "Enter your email",
              fillcolor: lightBlue,
              controller: email,
              kebordtype: TextInputType.emailAddress,
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "Enter your work experience",
              fillcolor: lightBlue,
              controller: experience,
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "Enter your work shop name",
              fillcolor: lightBlue,
              controller: workshop,
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "Enter your location",
              fillcolor: lightBlue,
              controller: location,
              validator: (value) {},
              readonly: true,
            ),
            Padding(
              padding: const EdgeInsets.only(
                      top: 30, left: 40, right: 40, bottom: 50)
                  .r,
              child: CustomButton(
                  btnname: "Done",
                  btntheam: customBlue,
                  textcolor: white,
                  click: () {}),
            )
          ]),
        ),
      ),
    );
  }
}
