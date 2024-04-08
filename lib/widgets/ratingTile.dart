import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color.dart';
import 'apptext.dart';

class RatingTile extends StatefulWidget {
  RatingTile({
    super.key,
    required this.image,
    required this.name,
    required this.work,
    required this.date,
    required this.time,
    required this.place,
  });

  final String image;
  final String name;
  final String work;
  final String date;
  final String time;
  final String place;

  @override
  State<RatingTile> createState() => _RatingTileState();
}

class _RatingTileState extends State<RatingTile> {
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: maincolor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
           
            SizedBox(
              width: 140,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                        text: widget.name,
                        weight: FontWeight.w400,
                        size: 16,
                        textcolor: customBalck),
                    const AppText(
                        text: "Rating",
                        weight: FontWeight.w400,
                        size: 10,
                        textcolor: customBalck),
                    AppText(
                        text: widget.work,
                        weight: FontWeight.w400,
                        size: 16,
                        textcolor: customBalck),
                    
                  ]),
            ),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                RatingBar.builder(
                          itemSize: 20,
                          initialRating: double.parse(widget.work),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                          onRatingUpdate: (rating) {
                            
                              rate = rating;
                            
                          },
                        ),
                        SizedBox(
                          width: 100,
                          child: Center(child: Text(widget.date)))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
