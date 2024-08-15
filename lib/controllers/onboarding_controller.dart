import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  Map<String, dynamic> onboardingData = {};
  final _db = FirebaseFirestore.instance;


  String heading = '';
  String subheading = '';
  String docid = '';
  String videoUrl = '';




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
