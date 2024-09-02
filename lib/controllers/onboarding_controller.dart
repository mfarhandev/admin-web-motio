import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  Map<String, dynamic> onboardingData = {};
  final _db = FirebaseFirestore.instance;


  String heading = '';
  String subheading = '';
  String docid = '';
  String videoUrl = '';



  Future<void> updateOnboardingData({
    required String docid,
    required String heading,
    required String subheading,
    required String videoUrl,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('onboarding').doc(docid).update({
        'heading': heading,
        'subheading': subheading,
        'videoUrl': videoUrl,
      });
      Get.snackbar(
        "Success",
        "Onboarding data updated successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update onboarding data",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> fetchOnboardingData() async {
    final data = await _db.collection('onboarding_videos').limit(1).get();
    if (data.docs.isNotEmpty) {
      onboardingData = data.docs.first.data();
      docid =  onboardingData['docId'] = data.docs.first.id; // Store the docId
      heading = onboardingData['heading'] ?? '';
      subheading = onboardingData['sub_heading'] ?? '';
      videoUrl = onboardingData['video_url'] ?? '';
    }
    update();
  }


}
