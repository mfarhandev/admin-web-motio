import 'dart:developer';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_web/utils/globals.dart';

class FirebaseStorageServices  extends GetxController{

  bool loading = false;

  bool check = false;

  Uint8List? videoFile;

  RxBool done = false.obs;

  Future<String> uploadToStorage({required File file, required String folderName, String contentType = 'image/jpeg'}) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            '$folderName/file${DateTime.now().millisecondsSinceEpoch}',
          );

      final UploadTask uploadTask = firebaseStorageRef.putBlob(
        file,
        SettableMetadata(contentType: contentType),
      );

      final TaskSnapshot downloadUrl = await uploadTask;

      String url = await downloadUrl.ref.getDownloadURL();

      return url;
    } on Exception catch (e) {
      log(e.toString());
      return "";
    }
  }


  TextEditingController headingController = TextEditingController();
  TextEditingController subHeadingController = TextEditingController();


  Future<void> uploadVideo(Uint8List? videoFile) async {

    loading = true;
    update();

    if (videoFile == null) return;
    try {
      final docRef = FirebaseFirestore.instance.collection('onboarding_videos').doc();
      File file = await convertBytesToFile(videoFile, 'test');
      final videoUrl = await FirebaseStorageServices().uploadToStorage(file: file,    folderName: "onboarding_videos/${docRef.id}", contentType: 'video/mp4',);


      await FirebaseFirestore.instance.collection('onboarding_videos').doc(docRef.id).set({
        'heading': headingController.text,
        'sub_heading': subHeadingController.text,
        'video_url': videoUrl,
      });

      loading = false;
      update();

      Get.snackbar(
        "Success",
        "Video uploaded successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      loading = false;
      update();
      print('Error uploading video: $e');
      Get.snackbar(
        "Error",
        "Error uploading video",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> deleteVideo(String docId, String videoUrl) async {
    loading = true;
    update();

    try {
      // Delete the video from Firebase Storage
      final Reference firebaseStorageRef = FirebaseStorage.instance.refFromURL(videoUrl);
      await firebaseStorageRef.delete();

      // Delete the document from Firestore
      await FirebaseFirestore.instance.collection('onboarding_videos').doc(docId).delete();

      // Clear the states and update the UI
      headingController.clear();
      subHeadingController.clear();
      check = false;
      videoFile = null;
      loading = false;
      update();

      Get.snackbar(
        "Success",
        "Video deleted successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      loading = false;
      update();
      print('Error deleting video: $e');
      Get.snackbar(
        "Error",
        "Error deleting video",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}
