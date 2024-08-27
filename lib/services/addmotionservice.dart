import 'dart:developer';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_web/services/FirebaseStorageServices.dart';
import 'package:motion_web/utils/globals.dart';

class AddMotionService extends GetxController {
  bool check = false;
  Uint8List? videoFile;
  bool loading = false;

  final TextEditingController titileController = TextEditingController();
  final TextEditingController header1Controller = TextEditingController();
  final TextEditingController header2Controller = TextEditingController();
  final TextEditingController header3Controller = TextEditingController();
  final TextEditingController equipementController = TextEditingController();
  final TextEditingController StartingpositionController = TextEditingController();
  final TextEditingController ExerciseDescriptionController = TextEditingController();



  Future<void> uploadVideo(Uint8List? videoFilee, String selectedExercise, String selectedReason) async {
    loading = true;
    update();

    if (videoFilee == null) return;
    try {
      final docRef = FirebaseFirestore.instance.collection('motion_videos').doc();
      File file = await convertBytesToFile(videoFilee, 'test');
      final videoUrl = await FirebaseStorageServices().uploadToStorage(
        file: file,
        folderName: "motion_exercises/${docRef.id}",
        contentType: 'video/mp4',
      );

      // Fetch the current highest index
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(selectedExercise)
          .collection('reasons')
          .doc(selectedReason)
          .collection('motions')
          .orderBy('index', descending: true)
          .limit(1)
          .get();

      int newIndex = 0;
      if (querySnapshot.docs.isNotEmpty) {
        newIndex = querySnapshot.docs.first['index'] + 1;
      }

      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(selectedExercise)
          .collection('reasons')
          .doc(selectedReason)
          .collection('motions')
          .doc(docRef.id)
          .set({
        'title': titileController.text,
        'header1': header1Controller.text,
        'header2': header2Controller.text,
        'header3': header3Controller.text,
        'equipmentsNeeded': equipementController.text,
        'starting_position': StartingpositionController.text,
        'exercise_description': ExerciseDescriptionController.text,
        'video_url': videoUrl,
        'index': newIndex,
      });

      loading = false;
      update();
      videoFile = null;
      titileController.clear();
      header1Controller.clear();
      header2Controller.clear();
      header3Controller.clear();
      equipementController.clear();
      StartingpositionController.clear();
      ExerciseDescriptionController.clear();

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

  Future<List<Map<String, dynamic>>> getMotionsForReason(String exerciseId, String reasonId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(exerciseId)
          .collection('reasons')
          .doc(reasonId)
          .collection('motions')
          .orderBy('index')
          .get();
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        'title': doc['title'],
        'equipmentsNeeded': doc['equipmentsNeeded'],
        'starting_position': doc['starting_position'],
        'exercise_description': doc['exercise_description'],
        'video_url': doc['video_url'],
        'index': doc['index'],
      }).toList();
    } catch (e) {
      print('Error fetching motions: $e');
      return [];
    }
  }

  Future<void> deleteMotion(String exerciseId, String reasonId, String motionId) async {
    try {
      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(exerciseId)
          .collection('reasons')
          .doc(reasonId)
          .collection('motions')
          .doc(motionId)
          .delete();
      Get.snackbar(
        "Success",
        "Motion deleted successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error deleting motion: $e');
      Get.snackbar(
        "Error",
        "Error deleting motion",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateMotionIndex(String exerciseId, String reasonId, String motionId, int newIndex) async {
    try {
      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(exerciseId)
          .collection('reasons')
          .doc(reasonId)
          .collection('motions')
          .doc(motionId)
          .update({'index': newIndex});

      // Get.snackbar(
      //   "Success",
      //   "Motion index updated successfully",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } catch (e) {
      print('Error updating motion index: $e');
      Get.snackbar(
        "Error",
        "Error updating motion index",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}