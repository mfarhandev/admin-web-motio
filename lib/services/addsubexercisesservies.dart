import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSubExercisesServies extends GetxController {

  bool loading = false;

  Future<void> addReasonToExercise(String docId, String reason,String description) async {
    loading = true;
    update();

    try {
      // Fetch the current highest index
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .collection('reasons')
          .orderBy('index', descending: true)
          .limit(1)
          .get();

      int newIndex = 0;
      if (querySnapshot.docs.isNotEmpty) {
        newIndex = querySnapshot.docs.first['index'] + 1;
      }

      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .collection('reasons')
          .add({
        'reason': reason,
        'description': description,
        'index': newIndex,
      });

      loading = false;
      update();
      Get.snackbar(
        "Success",
        "Reason added successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      log('Error adding reason: $e');
      loading = false;
      update();
      Get.snackbar(
        "Error",
        "Error adding reason",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getReasonsForExercise(String docId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .collection('reasons')
          .orderBy('index')
          .get();

      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        'reason': doc.data()['reason'],
        'description': doc.data()['description'],
        'index': doc.data()['index']
      }).toList();
    } catch (e) {
      log('Error fetching reasons: $e');
      return [];
    }
  }

  Future<void> deleteReasonFromExercise(String docId, String reasonId) async {
    try {
      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .collection('reasons')
          .doc(reasonId)
          .delete();

      Get.snackbar(
        "Success",
        "Reason deleted successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      log('Error deleting reason: $e');
      Get.snackbar(
        "Error",
        "Error deleting reason",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateReasonIndex(String docId, String reasonId, int newIndex) async {
    try {
      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .collection('reasons')
          .doc(reasonId)
          .update({'index': newIndex});

      // Get.snackbar(
      //   "Success",
      //   "Reason index updated successfully",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );

    } catch (e) {
      log('Error updating reason index: $e');
      Get.snackbar(
        "Error",
        "Error updating reason index",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



}