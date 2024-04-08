import 'package:break_down_assistance/Screens/mecanic/MechHome.dart';
import 'package:break_down_assistance/Screens/mecanic/RejectScreen.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/requestTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class AcceptScreen extends StatefulWidget {
  String rid;
  String date;
  String time;
  String place;
  String issue;
  AcceptScreen(
      {super.key,
      required this.rid,
      required this.date,
      required this.time,
      required this.place,
      required this.issue});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

int selectedOption = 1;
final description = TextEditingController();
final amount = TextEditingController();

class _AcceptScreenState extends State<AcceptScreen> {
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
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            RequestTile(
              image: "assets/men2.png",
              name: "name",
              issue: widget.issue,
              date: widget.date,
              time: widget.time,
              place: widget.place,
              click: () {},
            ),
            SizedBox(
              height: 80.h,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                  text: "Add status",
                  weight: FontWeight.w400,
                  size: 20,
                  textcolor: customBalck),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    activeColor: customBlue,
                  ),
                  const AppText(
                      text: "Completed",
                      weight: FontWeight.w400,
                      size: 14,
                      textcolor: customBalck)
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    activeColor: customBlue,
                  ),
                  const AppText(
                      text: "Not Completed",
                      weight: FontWeight.w400,
                      size: 14,
                      textcolor: customBalck)
                ],
              ),
            ]),
            // if (selectedOption == 2)
              // SizedBox(
              //   height: 50.h,
              // ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: AppText(
              //     text: "Reason",
              //     weight: FontWeight.w400,
              //     size: 20,
              //     textcolor: customBalck,
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              if (selectedOption == 2)
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    // height: 43.h,
                    child: Column(
                      children: [
                        Text('Reason',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          controller: description,
                          maxLines: 5,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              // vertical: 15.h,
                              // horizontal: 25.w,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: customBalck),
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: customBalck),
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
           

            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: AppText(
            //       text: "Amount",
            //       weight: FontWeight.w400,
            //       size: 20,
            //       textcolor: customBalck),
            // ),
            // SizedBox(
            //   height: 50.h,
            // ),
            if (selectedOption == 1)
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: SizedBox(
                  height: 80.h,
                  child: Column(
                    children: [
                      Text('AMOUNT',style: TextStyle(fontWeight: FontWeight.bold),),
                      TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.currency_rupee),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 15.w,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: customBalck),
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: customBalck),
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 80).r,
              child: CustomButton(
                  btnname: "Submit",
                  btntheam: customBlue,
                  textcolor: white,
                  click: () {
                    if(selectedOption==1){
                      updateAmount();
                    }
                    if(selectedOption==2){
                     updateAmount1();
                    }
                    
                  }),
            )
          ]),
        ),
      ),
    );
  }
  Future<void> updateAmount() async {
    print('///////////////////////////////////////${amount.text}');
  try {
    await FirebaseFirestore.instance
        .collection('mechrequest')
        .doc(widget.rid)
        .update({
      'amount': amount.text,
      'status':"3"
    });
    print('Amount updated successfully');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
      return MechHome();
    }));
  } catch (e) {
    print('Error updating amount: $e');
  }
}

 Future<void> updateAmount1() async {
    print('///////////////////////////////////////${amount.text}');
  try {
    await FirebaseFirestore.instance
        .collection('mechrequest')
        .doc(widget.rid)
        .update({
      'reason': description.text,
      'status':"4"
    });
    print('Amount updated successfully');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
      return MechHome();
    }));
  } catch (e) {
    print('Error updating amount: $e');
  }
}
}
