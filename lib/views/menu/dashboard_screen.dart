// dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_web/controllers/onboarding_controller.dart';
import 'package:motion_web/services/FirebaseStorageServices.dart';

import 'package:motion_web/utils/customcolor.dart';
import 'package:motion_web/views/auth/Login_screen.dart';
import 'package:motion_web/views/menu/addexercises_screen.dart';
import 'package:motion_web/views/menu/addmotions_screen.dart';
import 'package:motion_web/views/menu/addsubexercises_screen.dart';
import 'package:motion_web/views/menu/onboarding_screen.dart';
import 'package:motion_web/widgets/text_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  final onboardingfirebase = Get.put(FirebaseStorageServices());
  final onboardingcntrl = Get.put(OnboardingController());




  int _selectedIndex = 0;

  final List _screens = [
    OnboardingScreen(),
    AddexErcisesScreen(),
    AddSubexercisesScreen(),
    AddMotionsScreen(),
  ];

  void _onMenuTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth * 0.15,
            color: Colors.blue.shade100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Replace with your logo path
                    width: screenWidth * 0.1,
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  GestureDetector(
                    onTap: () => _onMenuTapped(0),
                    child: AppText.heading("On Boarding", color: Colors.black, fontsize: 18),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(color: Colors.white),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => _onMenuTapped(1),
                    child: AppText.heading("Add Exercise", color: Colors.black, fontsize: 18),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(color: Colors.white),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => _onMenuTapped(2),
                    child: AppText.heading("Add Reason", color: Colors.black, fontsize: 18),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(color: Colors.white),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => _onMenuTapped(3),
                    child: AppText.heading("Add Motions", color: Colors.black, fontsize: 18),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(color: Colors.white),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child:  AppText.heading("Logout", color: Colors.black, fontsize: 18),
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _screens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
