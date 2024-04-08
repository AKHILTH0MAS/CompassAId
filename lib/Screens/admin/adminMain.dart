import 'package:break_down_assistance/Screens/admin/userList.dart';
import 'package:break_down_assistance/Screens/common/Log.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mecanicList.dart';

class AdminMain extends StatelessWidget {
  const AdminMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: CircleAvatar(
          //   radius: 30.r,
          //   backgroundImage: const AssetImage("assets/admin.png"),
          // ),
          actions: [
            IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
              return Login();
            }));
          }, icon: Icon(Icons.logout_rounded))],
        ),
        backgroundColor: lightBlue,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20).r,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r, color: white),
                child: TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      "User",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
                    Tab(
                      child: Text(
                        "Mechanic",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10).r),
                      // Creates border
                      color: tabcolor),
                  labelColor: white,
                  unselectedLabelColor: customBalck,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Expanded(
                child: TabBarView(children: [
              Center(child: UserList()),
              Center(child: MechanicList())
            ]))
          ]),
        ),
      ),
    );
  }
}
