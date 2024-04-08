import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 70, right: 70, top: 150).r,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const AppText(
                  text: "successful",
                  weight: FontWeight.w400,
                  size: 24,
                  textcolor: customBalck),
              Padding(
                padding: const EdgeInsets.only(top: 200).r,
                child: CustomButton(
                    btnname: "Back to home page",
                    btntheam: customBlue,
                    textcolor: white,
                    click: () {}),
              )
            ]),
      ),
    );
  }
}
