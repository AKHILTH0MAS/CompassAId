import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingScreen extends StatefulWidget {
  String req_id;
  String user_id;
  String mech_id;
  RatingScreen({super.key, required this.req_id,required this.user_id, required this.mech_id, });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {

  var feedback = TextEditingController();
  double ratvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: customBalck,
          ),
        ),
        title: const AppText(
            text: "Your rating",
            weight: FontWeight.w400,
            size: 20,
            textcolor: customBalck),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 45, right: 45, top: 10, bottom: 20).r,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              "assets/men3.png",
              width: 150.w,
              height: 150.h,
              fit: BoxFit.fill,
            ),
            const AppText(
                text: "Name",
                weight: FontWeight.w400,
                size: 16,
                textcolor: customBalck),
            SizedBox(
              height: 15.h,
            ),
            const AppText(
                text: "2+ year experience",
                weight: FontWeight.w400,
                size: 14,
                textcolor: customBalck),
            SizedBox(
              height: 10.h,
            ),
            Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: const AppText(
                    text: "Available",
                    weight: FontWeight.w400,
                    size: 12,
                    textcolor: white),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            RatingBar.builder(
              initialRating: ratvalue,
              minRating: 1,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 25,
              unratedColor: Colors.yellow[100],
              itemPadding: const EdgeInsets.symmetric(horizontal: 1),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print('.....................$rating');
                (rating);
              
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                  text: "Add rating",
                  weight: FontWeight.w400,
                  size: 16,
                  textcolor: customBalck),
            ),
            SizedBox(
              height: 15.h,
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 45,
              unratedColor: customBalck,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1),
              itemBuilder: (context, _) => const Icon(
                Icons.star_border,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                //print(rating);
                setState(() {
                  ratvalue = rating;
                });
                print(ratvalue);
              },
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: 'Add your review...',
              ),
              controller: feedback,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 40.w),
              child: InkWell(
                onTap: (){
                  
                },
                child: CustomButton(
                    btnname: "Submit",
                    btntheam: customBlue,
                    textcolor: white,
                    click: () async {
                      print('object');
                     await FirebaseFirestore.instance.collection('rating').add(
                      {
                        'user_id' : widget.user_id,
                        'mech_id' : widget.mech_id,
                        'rating' : ratvalue,
                        'feedback':feedback.text
                      }
                     );
                     Navigator.pop(context);
                    }),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
