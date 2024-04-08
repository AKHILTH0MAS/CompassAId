import 'package:break_down_assistance/Screens/mecanic/MechHome.dart';
import 'package:break_down_assistance/Screens/user/Forgot%20password.dart';
import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserHome.dart';
import 'UserSignup.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  var userId;
  var name;
  var email;
  var phone;
  var location;

  @override
  void initState() {
    super.initState();
    // Initialize controllers if needed
    usernameController.text = '';
    passwordController.text = '';
  }

  void login(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Simulate a delay for login (Replace with your actual login logic)
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });

      final QuerySnapshot<Map<String, dynamic>> mechSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: usernameController.text)
              .where('password', isEqualTo: passwordController.text)
              .where('status', isEqualTo: 1)
              .get();

      if (mechSnapshot.docs.isNotEmpty) {
        setState(() {
          userId = mechSnapshot.docs[0].id;
          name = mechSnapshot.docs[0]['username'];
          email = mechSnapshot.docs[0]['email'];
          phone = mechSnapshot.docs[0]['phone'];
          location = mechSnapshot.docs[0]['location'];
        });

        // print('.................$mechId');
        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('user_id', userId);
        spref.setString('name', name);
        spref.setString('email', email);
        spref.setString('phone', phone);
        spref.setString('location', location);

        var nm = spref.getString('name');
        var em = spref.getString('email');
        var ph = spref.getString('phone');
        var loc = spref.getString('location');

        // Fluttertoast.showToast(msg: 'Login Successful as User');
        print('Mechanic ID: $userId');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return UserHome();
        }));
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content:
                const Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: maincolor,
        body: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45, top: 10).r,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 50).r,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 140.w,
                      height: 140.h,
                    ),
                  ),
                  const AppText(
                    text: "LOGIN",
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
                      text: "Enter Email",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    hint: "Email",
                    controller: usernameController,
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
                      text: "Enter Password",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    hint: "password",
                    controller: passwordController,
                    obscure: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a password';
                      }
                      // // Check if the password meets your criteria
                      // if (!RegExp(r'^(?=.*[a-zA-Z]){6,}$').hasMatch(value!)) {
                      //   return 'Password must contain alphabet and be at least 6 characters long.';
                      // }

                      
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          )); // SignUp ..................................
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                            text: "Forgot Password?",
                            weight: FontWeight.w400,
                            size: 13,
                            textcolor: customBlue),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50).r,
                    child: CustomButton(
                      btnname: isLoading ? "Logging In..." : "LOGIN",
                      btntheam: customBlue,
                      textcolor: white,
                      click: () {
                        login(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                          text: "Do you have account ?",
                          weight: FontWeight.w400,
                          size: 13,
                          textcolor: customBalck),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserSignup(),
                              )); // SignUp ..................................
                        },
                        child: const AppText(
                            text: "Sign up",
                            weight: FontWeight.w400,
                            size: 13,
                            textcolor: customBlue),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
