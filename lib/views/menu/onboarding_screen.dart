import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:motion_web/controllers/onboarding_controller.dart';
import 'package:motion_web/utils/customcolor.dart';
import 'package:motion_web/widgets/ElevatedButtonWidget.dart';
import 'package:motion_web/widgets/text_widget.dart';
import '../../services/FirebaseStorageServices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingfirebase = Get.put(FirebaseStorageServices());
  final onboardingcntrl = Get.put(OnboardingController());

  String docid = '';
  String videoUrl = '';
  bool isEditMode = false;

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mov'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        onboardingfirebase.videoFile = file.bytes!;
      });
    }
  }

  void getdata() async {
    await onboardingcntrl.fetchOnboardingData();
    if (onboardingcntrl.heading != '') {
      onboardingfirebase.headingController.text = onboardingcntrl.heading;
      onboardingfirebase.subHeadingController.text = onboardingcntrl.subheading;
      docid = onboardingcntrl.docid;
      videoUrl = onboardingcntrl.videoUrl;
      setState(() {
        onboardingfirebase.check = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onboardingfirebase.check == true && onboardingfirebase.check1 == false  ? () {} : pickVideo,
            child: (onboardingfirebase.check == false && onboardingfirebase.videoFile == null)
                ? Container(
              height: 150,
              width: screenWidth * 0.30,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: btncolor, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file_outlined, color: Colors.grey, size: 30),
                    AppText.normal("Upload the Onboarding Video", color: Colors.grey),
                  ],
                ),
              ),
            )
                : Container(
              height: 150,
              width: screenWidth * 0.30,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: btncolor, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file_outlined, color: Colors.blue, size: 30),
                    AppText.normal("Video Selected", color: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: screenWidth * 0.30,
            child: TextField(
              enabled: isEditMode ? true : false,
              maxLines: 2,
              cursorColor: Colors.blue,
              controller: onboardingfirebase.headingController,
              style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                hintText: 'Heading',
                hintStyle: TextStyle(fontFamily: "PTSerif", color: Colors.black.withOpacity(0.4)),
                fillColor: Colors.white24,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: screenWidth * 0.30,
            child: TextField(
              enabled: isEditMode ? true : false,
              maxLines: 3,
              cursorColor: Colors.blue,
              controller: onboardingfirebase.subHeadingController,
              style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                hintText: 'Sub Heading',
                hintStyle: TextStyle(fontFamily: "PTSerif", color: Colors.black.withOpacity(0.4)),
                fillColor: Colors.white24,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (onboardingfirebase.check == false)
                GetBuilder<FirebaseStorageServices>(builder: (logic) {
                  return logic.loading == true
                      ? Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                      : ElevatedButtonWidget(
                    buttonHeight: 60,
                    buttonborderRadius: 15,
                    buttonBackgroundColor: btncolor,
                    buttonWidth: screenWidth * 0.30,
                    onPressed: () async {
                      if (onboardingfirebase.headingController.text.isEmpty ||
                          onboardingfirebase.videoFile == null ||
                          onboardingfirebase.subHeadingController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Fill all the fields",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        await onboardingfirebase.uploadVideo(onboardingfirebase.videoFile);
                        setState(() {
                          onboardingfirebase.check = true;
                          isEditMode = false;
                        });
                      }
                    },
                    child: AppText.heading("Save", fontsize: 18, color: Colors.white),
                  );
                })
              else
                GetBuilder<FirebaseStorageServices>(builder: (logic) {
                  return logic.loading == true
                      ? Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                      : ElevatedButtonWidget(
                    buttonHeight: 60,
                    buttonborderRadius: 15,
                    buttonBackgroundColor: isEditMode ? Colors.blue : Colors.orange,
                    buttonWidth: screenWidth * 0.30,
                    onPressed: () async {

                      if (isEditMode) {
                        await onboardingfirebase.updateVideo(docid, videoUrl);
                        setState(() {

                          isEditMode = false;
                        });
                      } else {
                        setState(() {
                          onboardingfirebase.check1 = true;
                          isEditMode = true;
                        });
                      }
                    },
                    child: AppText.heading(
                        isEditMode ? "Update" : "Edit", fontsize: 18, color: Colors.white),
                  );
                }),
              SizedBox(width: 20),
              if (onboardingfirebase.check == true)
                GetBuilder<FirebaseStorageServices>(builder: (logic) {
                  return logic.deleteisloading == true
                      ? Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                      : ElevatedButtonWidget(
                    buttonHeight: 60,
                    buttonborderRadius: 15,
                    buttonBackgroundColor: Colors.red,
                    buttonWidth: screenWidth * 0.30,
                    onPressed: () async {
                      await onboardingfirebase.deleteVideo(docid, videoUrl);
                      setState(() {
                        onboardingfirebase.headingController.text = '';
                        onboardingfirebase.subHeadingController.text = '';
                        onboardingfirebase.check = false;
                        onboardingfirebase.videoFile = null;
                        isEditMode = true;
                      });
                    },
                    child: AppText.heading("Delete", fontsize: 18, color: Colors.white),
                  );
                }),
            ],
          ),


        ],
      ),
    );
  }
}
