import 'package:break_down_assistance/Screens/mecanic/update%20password.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  
  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

    var email ;
    var phone;

  @override
  void initState() {
    super.initState();
    // Initialize controllers if needed
    emailController.text = '';
    phoneController.text = '';
  }

  Future<void> forgotPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Simulate a delay for login (Replace with your actual login logic)
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });

       final QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('mechanic')
            .where('email', isEqualTo: emailController.text)
            .where('phone', isEqualTo: phoneController.text)
            .get();


      if (userSnapshot.docs.isNotEmpty) {
        var id = userSnapshot.docs[0].id;
        print('............................$id');
       

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return UpdatePassword(id: id,);
      }));
    } 
       else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Failed'),
            content: Text('Invalid Email or Mobile Number. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        backgroundColor: maincolor,
        body: Padding(
          padding: EdgeInsets.only(left: 45, right: 45, top: 10).r,
          child: Form(
            key: _formKey,
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                const AppText(
                  text: "Forgot password",
                  weight: FontWeight.w700,
                  size: 23,
                  textcolor: customBalck,
                ),
                SizedBox(
                  height: 50.h,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: AppText(
                    text: "Enter Registered Email",
                    weight: FontWeight.w500,
                    size: 16,
                    textcolor: customBalck,
                  ),
                ),
                CustomTextField(
                  hint: "Email",
                  controller: emailController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter  Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: AppText(
                    text: "Enter Mobile number",
                    weight: FontWeight.w500,
                    size: 16,
                    textcolor: customBalck,
                  ),
                ),
                CustomTextField(
                  hint: "Mobile",
                  controller: phoneController,
                  obscure: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter mobile number';
                    }
                    // Check if the password meets your criteria
                 
                    return null;
                  },
                ),
                
                SizedBox(
                  height: 80.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 50, right: 50).r,
                //   child: CustomButton(
                //     btnname: isLoading ? "Logging In..." : "LOGIN",
                //     btntheam: customBlue,
                //     textcolor: white,
                //     click: () {
                //     login(context);
                //   },
                //   ),
                // ),
                 SizedBox(
                height: 20.w,
              ),
                Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  forgotPassword();
                },
                child: const AppText(
                    text: "Update Password",
                    weight: FontWeight.w400,
                    size: 13,
                    textcolor: Color.fromARGB(255, 4, 58, 103)),
              ),
              SizedBox(
                width: 10.w,
              ),
             
            ],
          ),
               ],
            ),
          ),
        ),
      
    );
  }
}