import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';
import 'apptext.dart';

class NotificationTile extends StatelessWidget {
   NotificationTile({
    super.key,
    required this.heading,
    required this.contents,
  });

  var heading;
  var contents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: Container(
        height: 130.h,
        width: double.infinity,
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(10).r,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText(
                    text: heading,
                    weight: FontWeight.w500,
                    size: 16,
                    textcolor: customBalck),
                Text(
                  contents,
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: customBalck),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )
              ]),
        ),
      ),
    );
  }
}
