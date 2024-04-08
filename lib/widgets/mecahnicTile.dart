import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';
import 'apptext.dart';

class MechanicTile extends StatelessWidget {
  const MechanicTile({
    super.key,
    required this.name,
    required this.mobile,
    required this.service,
    required this.image, required this.click,
  });

  final String image;
  final String name;
  final String mobile;
  final String service;
 final void Function() click;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: InkWell(
        onTap:click ,
        child: Container(
          height: 120.h,
          width: double.infinity,
          color: white,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).r,
              child: Image.asset(
                image,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: name,
                        weight: FontWeight.w500,
                        size: 14.sp,
                        textcolor: customBalck),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppText(
                        text: mobile,
                        weight: FontWeight.w400,
                        size: 14.sp,
                        textcolor: customBalck),
                    Text(
                      service,
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: customBalck),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
