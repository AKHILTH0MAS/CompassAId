import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color.dart';
import 'apptext.dart';

class MechanicStatusTile extends StatelessWidget {
  const MechanicStatusTile(
      {super.key,
      required this.image,
      required this.name,
      required this.experience,
      required this.work,
      required this.status, 
      required this.click
      });

  final String image;
  final String name;
  final String experience;
  final String work;
  final bool status; //if status is true mechanic is available/false not available
 final void Function() click;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15).r,
      child: InkWell(
        onTap: click,
        child: Container(
          height: 123.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r, color: lightBlue),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 40, top: 10, bottom: 10).r,
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: 70.w,
                      height: 70.h,
                      fit: BoxFit.fill,
                    ),
                    AppText(
                        text: name,
                        weight: FontWeight.w400,
                        size: 14,
                        textcolor: customBalck)
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppText(
                          text: experience,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                      AppText(
                          text: work,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                      Card(
                        color: status == true ? Colors.green : Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: AppText(
                              text: status == true ? "Available" : "Unavailable",
                              weight: FontWeight.w400,
                              size: 12,
                              textcolor: white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
