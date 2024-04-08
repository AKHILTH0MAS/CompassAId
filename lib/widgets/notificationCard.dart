import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';
import 'apptext.dart';

class NotifiactionCard extends StatelessWidget {
  const NotifiactionCard({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.content
  });

  final String title;
  final String time;
  final String date;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: customBalck),
          borderRadius: BorderRadius.circular(12).r),
      child: Padding(
        padding: const EdgeInsets.all(10).r,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          AppText(
              text: time,
              weight: FontWeight.w400,
              size: 12,
              textcolor: customBalck),
          Padding(
            padding: const EdgeInsets.only(right: 10).r,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color.fromARGB(255, 6, 0, 0)),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      content,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                )),
          ),
          
          AppText(
              text: date,
              weight: FontWeight.w400,
              size: 12,
              textcolor: const Color.fromARGB(255, 72, 71, 71)),
        ]),
      ),
    );
  }
}
