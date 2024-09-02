import 'dart:developer';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_web/utils/globals.dart';



class AddExercisesServices extends GetxController {


  TextEditingController exerciseController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Uint8List? imageFile;

  bool loading = false;
  bool loading1 = false;






  Future<String> uploadToStorageImage({required Uint8List fileData, required String folderName, String contentType = 'image/png'}) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        '$folderName/file${DateTime.now().millisecondsSinceEpoch}.png',
      );

      final UploadTask uploadTask = firebaseStorageRef.putData(
        fileData,
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



  Future<void> uploadImage(Uint8List? imageFilee) async {
    if (imageFilee == null)
      return;

    loading = true;
    update();

    try {
      // Fetch the current highest index
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .orderBy('index', descending: true)
          .limit(1)
          .get();

      int newIndex = 0;
      if (querySnapshot.docs.isNotEmpty) {
        newIndex = querySnapshot.docs.first['index'] + 1;
      }

      final docRef = FirebaseFirestore.instance.collection('All_exercises').doc();
      final imageUrl = await uploadToStorageImage(
        fileData: imageFilee,
        folderName: "exercises_images/${docRef.id}",
        contentType: 'image/png',
      );

      await FirebaseFirestore.instance.collection('All_exercises').doc(docRef.id).set({
        'exercise': exerciseController.text,
        'description': descriptionController.text,
        'image_url': imageUrl,
        'index': newIndex,
      });

      exerciseController.clear();
      descriptionController.clear();
      imageFile = null;
      loading = false;
      update();

      Get.snackbar(
        "Success",
        "Exercise uploaded successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      log('Error uploading image: $e');
      loading = false;
      update();
      Get.snackbar(
        "Error",
        "Error uploading exercise",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }




  Future<List<Map<String, dynamic>>> getAllExercises() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('All_exercises')
          .orderBy('index')
          .get();
      return querySnapshot.docs.map((doc) => {
        'docId': doc.id,
        ...doc.data() as Map<String, dynamic>
      }).toList();
    } catch (e) {
      log('Error fetching exercises: $e');
      return [];
    }
  }


  Future<void> updateExerciseIndex(String docId, int newIndex) async {
    try {
      await FirebaseFirestore.instance
          .collection('All_exercises')
          .doc(docId)
          .update({'index': newIndex});
    } catch (e) {
      log('Error updating exercise index: $e');
    }
  }


  Future<void> updateExercise(String docId, String exercise, String description, Uint8List? imageFilee) async {
    try {
      loading = true;
      update();

      print('imageFile: $imageFilee');


      // Check if the document exists
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('All_exercises').doc(docId).get();
      if (!docSnapshot.exists) {
        throw Exception("No document to update");
      }

      String? imageUrl;
      if (imageFilee != null && imageFile!.isNotEmpty) {

        imageUrl = await uploadToStorageImage(
          fileData: imageFilee,
          folderName: "exercises_images/$docId",
          contentType: 'image/png',
        );
      }

      await FirebaseFirestore.instance.collection('All_exercises').doc(docId).update({
        'exercise': exercise,
        'description': description,
        if (imageUrl != null) 'image_url': imageUrl,
      });

      loading = false;
      exerciseController.clear();
      descriptionController.clear();
      imageFile = null;
      update();
      Get.snackbar("Success", "Exercise updated successfully",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      loading = false;
      update();
      print('Error updating exercise: $e');
      Get.snackbar("Error", "Error updating exercise",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }




  Future<void> deleteExercise(String docId) async {

    loading1 = true;
    update();

    if (docId.isEmpty) {

      loading1 = false;
      update();

      Get.snackbar(
        "Error",
        "Document ID is empty",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      loading1 = false;
      update();
      await FirebaseFirestore.instance.collection('All_exercises').doc(docId).delete();

      Get.snackbar(
        "Success",
        "Exercise deleted successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {

      loading1 = false;
      update();

      log('Error deleting exercise: $e');
      Get.snackbar(
        "Error",
        "Error deleting exercise",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}
