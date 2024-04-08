import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ServiceScreen extends StatefulWidget {
  String name;
  String exp;
  String mob;
  String mech;
  ServiceScreen({
    Key? key,
    required this.name,
    required this.exp,
    required this.mob,
    required this.mech,
  });

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  var note = TextEditingController();
  final amount = TextEditingController();
  List<String> droplist = ["Fuel leaking", "Engin work", "Tyre alignment", "Others"];
  List<String> droplist2 = [];
  String? selectedvalue;
  final place = TextEditingController();

  Future<void> sendRequest() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var id = spref.getString('user_id');
    String noteText = note.text;
    String selectedDropdownValue = selectedvalue ?? "Not selected";
    String placeText = place.text;
    

    String dt1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String tm1 = DateFormat('HH:mm').format(DateTime.now());

    Map<String, dynamic> requestData = {
      'customer_id': id,
      'mech_id': widget.mech,
      'note': noteText,
      'issue': selectedDropdownValue,
      'place': placeText,
      'date': dt1,
      'time': tm1,
      'status': '0',
      'amount': '0',
      'reason': '0',
    };

    try {
      await FirebaseFirestore.instance.collection('mechrequest').add(requestData);

      print('Request sent successfully!');
      Navigator.pop(context);
    } catch (e) {
      print('Error sending request: $e');
    }
  }

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
          text: "Needed service",
          weight: FontWeight.w400,
          size: 20,
          textcolor: customBalck,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45, top: 10, bottom: 20).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/men3.png",
                width: 100.w,
                height: 100.h,
                fit: BoxFit.fill,
              ),
              AppText(
                text: widget.name,
                weight: FontWeight.w400,
                size: 16,
                textcolor: customBalck,
              ),
              SizedBox(
                height: 15.h,
              ),
              AppText(
                text: widget.mob,
                weight: FontWeight.w400,
                size: 14,
                textcolor: customBalck,
              ),
              SizedBox(
                height: 10.h,
              ),
               const Align(
                alignment: Alignment.center,
                child: AppText(
                  text: "Other Services",
                  weight: FontWeight.w400,
                  size: 16,
                  textcolor: customBalck,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
             
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('service')
                    .where('mech_id', isEqualTo: widget.mech)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final services = snapshot.data?.docs ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(services[index]['service'],
                          style: const TextStyle(color: Color.fromARGB(255, 3, 93, 167)),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: "Add needed service",
                  weight: FontWeight.w400,
                  size: 16,
                  textcolor: customBalck,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Flexible(
                    child: Card(
                      color: lightBlue,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        elevation: 0,
                        dropdownColor: lightBlue,
                        hint: const Text("Issue"),
                        underline: const SizedBox(),
                        value: selectedvalue,
                        items: droplist.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            selectedvalue = newvalue;
                          });
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Card(
                color: lightBlue,
                child: TextFormField(
                  controller: note,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'Vehicle type and details'),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const AppText(
                    text: "Place",
                    weight: FontWeight.w400,
                    size: 16,
                    textcolor: customBalck,
                  ),
                ),
              ),
              CustomTextField(
                hint: "place",
                fillcolor: lightBlue,
                controller: place,
                validator: (value) {
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40).r,
                child: CustomButton(
                  btnname: "Request",
                  btntheam: customBlue,
                  textcolor: white,
                  click: () {
                    sendRequest();
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}
