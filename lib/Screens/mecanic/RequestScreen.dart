import 'package:break_down_assistance/Screens/mecanic/MechHome.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'RejectScreen.dart';

class RequestScreen extends StatefulWidget {
  String req_id;
  String name;
  String issue;
  String place;
  String date;
  String time;
  String status;
  String vehicleDetails;

  RequestScreen(
      {super.key,
      required this.req_id,
      required this.name,
      required this.issue,
      required this.place,
      required this.date,
      required this.time,
      required this.status,
      required this.vehicleDetails});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
            padding: const EdgeInsets.only(left: 30, right: 30).r,
            child: Center(
              child: Container(
                height: 500.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: maincolor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, top: 25).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: "Name",
                        weight: FontWeight.w400,
                        size: 14,
                        textcolor: customBalck,
                      ),
                      RowServiceCard(title: "Problem", subtitle: widget.issue),
                      const SizedBox(height: 20),
                       RowServiceCard(
                          title: "Place", subtitle: widget.place),
                      const SizedBox(height: 20),
                       RowServiceCard(title: "Date", subtitle: widget.date),
                      const SizedBox(
                        height: 20,
                      ),
                       RowServiceCard(title: "Time", subtitle: widget.time),
                      const SizedBox(height: 20),
                       RowServiceCard(
                          title: "Vehicle details", subtitle: widget.vehicleDetails),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      getButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 170).r,
            child: CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage("assets/men2.png"),
            ),
          ),
        ),
      ],
    );
  }

  Widget getButton() {
    if (widget.status == '1') {
      // Status is '1', show Accept button
      return CustomButton(
        btnname: "Accept",
        textsize: 15,
        height: 40,
        btntheam: Colors.green,
        textcolor: white,
        click: () async {
          print('Accept button clicked');
          await FirebaseFirestore.instance
              .collection('mechrequest')
              .doc(widget.req_id)
              .update({
            'status': '1',
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AcceptScreen(
          //     req_id:widget.req_id,
          //     date:widget.date,
          //     time:widget.time,
          //     place:widget.place,
          //     issue: widget.issue

          //     ),
          //   ),
          // );
          setState(() {
            Navigator.pop(context);
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //    builder: (ctx){
          //     return MechHome();
          //    }
          //   ),
          // );
        },
      );
    } else if (widget.status == '2') {
      // Status is '2', show Reject button
      return CustomButton(
        btnname: "Reject",
        height: 40,
        textsize: 15,
        btntheam: Colors.red,
        textcolor: white,
        click: () {
          print('Reject button clicked');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RejectScreen(),
            ),
          );
        },
      );
    } else {
      // Default case: Status is '0' or unknown, show both Accept and Reject buttons
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              btnname: "Accept",
              textsize: 15,
              height: 40,
              btntheam: Colors.green,
              textcolor: white,
              click: () async {
                print('Accept button clicked');
                await FirebaseFirestore.instance
                    .collection('mechrequest')
                    .doc(widget.req_id)
                    .update({
                  'status': '1',
                });
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) {
                      return MechHome();
                    }),
                  );
                });
              },
            ),
          ),
          const SizedBox(width: 10), // Add some spacing between buttons
          Expanded(
            child: CustomButton(
              btnname: "Reject",
              height: 40,
              textsize: 15,
              btntheam: Colors.red,
              textcolor: white,
              click: () async {
                print('Reject button clicked');
                await FirebaseFirestore.instance
                    .collection('mechrequest')
                    .doc(widget.req_id)
                    .update({
                  'status': '2',
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RejectScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
class RowServiceCard extends StatelessWidget {
  const RowServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 90,
          height: 14,
          child: Text(
            ': $subtitle ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
