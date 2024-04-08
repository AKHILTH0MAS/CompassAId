import 'package:break_down_assistance/constants/color.dart';
import 'package:break_down_assistance/widgets/apptext.dart';
import 'package:break_down_assistance/widgets/customButton.dart';
import 'package:break_down_assistance/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'adminHome.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });

      if (usernameController.text == 'admin@gmail.com' && passwordController.text == 'admin@123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHome(),
          ),
        );
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
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
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: maincolor,
        body: Padding(
          padding: EdgeInsets.only(left: 45, right: 45, top: 10).r,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 50).r,
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
                      text: "Enter Username",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    hint: "username",
                    controller: usernameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a username';
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
                      // Check if the password meets your criteria
                      if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$').hasMatch(value!)) {
                        return 'Password must contain at least one alphabet and one number, and be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50).r,
                    child: CustomButton(
                      btnname: isLoading ? "Logging In..." : "LOGIN",
                      btntheam: customBlue,
                      textcolor: white,
                      click: () {
                      login(context);
                    },
                    ),
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
