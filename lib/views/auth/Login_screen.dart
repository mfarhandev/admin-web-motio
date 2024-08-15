

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motion_web/utils/customcolor.dart';
import 'package:motion_web/views/menu/dashboard_screen.dart';
import 'package:motion_web/widgets/ElevatedButtonWidget.dart';
import 'package:motion_web/widgets/PwdTextFormFieldWidget.dart';
import 'package:motion_web/widgets/TextFormFieldWidget.dart';
import 'package:motion_web/widgets/text_widget.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Get the width and height of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    log("screenWidth: $screenWidth, screenHeight: $screenHeight");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          children: [
            // Logo on the left side
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(0),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your logo path
                    width: screenWidth * 0.3,
                  ),
                ),
              ),
            ),
            // Text fields on the right side
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormFieldWgt(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      labelText: "Email",
                      hintText: "Email",
                      borderRadius: 30,
                    ),
                    //space
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    PwdTextFormFieldWidget(
                      controller: passwordcontroller,
                      labelText: "Password",
                      hintText: "Password",
                    ),

                    SizedBox(
                      height: screenHeight * 0.03,
                    ),

                    ElevatedButtonWidget(
                        buttonHeight: 60,
                        buttonborderRadius: 30,
                        buttonBackgroundColor: btncolor,
                        buttonWidth: screenWidth / 1.1,
                        onPressed: (){
                          if(emailcontroller.value.text == "2665525@gmail.com" && passwordcontroller.value.text == "Alex123Alex123"){

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));

                          }
                          else {

                            Get.snackbar(
                              "Login Failed",
                              "Invalid email or password",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));


                        },
                        child: AppText.heading("Sign In",fontsize: 18,color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}