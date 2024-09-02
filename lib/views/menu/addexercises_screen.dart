import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:motion_web/services/addexercisesservices.dart';
import 'package:motion_web/utils/customcolor.dart';
import 'package:motion_web/widgets/ElevatedButtonWidget.dart';
import 'package:motion_web/widgets/networkimage_widget.dart';
import 'package:motion_web/widgets/text_widget.dart';

class AddexErcisesScreen extends StatefulWidget {
  const AddexErcisesScreen({super.key});

  @override
  State<AddexErcisesScreen> createState() => _AddexErcisesScreenState();
}

class _AddexErcisesScreenState extends State<AddexErcisesScreen> {
  final addexercisesservice = Get.put(AddExercisesServices());

  bool isEditMode = false;
  String? selectedDocId;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        addexercisesservice.imageFile = file.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: pickImage,
                    child: addexercisesservice.imageFile == null
                        ? Container(
                      height: 200,
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
                            Icon(Icons.upload_file_outlined,
                                color: Colors.grey, size: 30),
                            AppText.normal("Upload the Exercise Image",
                                color: Colors.grey),
                          ],
                        ),
                      ),
                    )
                        : Container(
                      height: 200,
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
                            Icon(Icons.upload_file_outlined,
                                color: btncolor, size: 30),
                            AppText.normal("Image Selected",
                                color: btncolor),
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.30,
                  child: TextField(
                    maxLines: 1,
                    cursorColor: Colors.blue,
                    controller: addexercisesservice.exerciseController,
                    style:
                    TextStyle(fontFamily: "PTSerif", color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        hintText: 'Exercise Name',
                        hintStyle: TextStyle(
                          fontFamily: "PTSerif",
                          color: Colors.black.withOpacity(0.4),
                        ),
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
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.30,
                  child: TextField(
                    maxLines: 3,
                    cursorColor: Colors.blue,
                    controller: addexercisesservice.descriptionController,
                    style:
                    TextStyle(fontFamily: "PTSerif", color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontFamily: "PTSerif",
                          color: Colors.black.withOpacity(0.4),
                        ),
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
                        )),
                  ),
                ),
                SizedBox(height: 10),
                GetBuilder<AddExercisesServices>(builder: (logic) {
                  return logic.loading == true
                      ? Center(
                      child: SpinKitFadingCircle(
                        size: 50,
                        color: Colors.blue,
                      ))
                      : ElevatedButtonWidget(
                    buttonHeight: 50,
                    buttonborderRadius: 15,
                    buttonBackgroundColor: btncolor,
                    buttonWidth: screenWidth * 0.30,
                    onPressed: () async {
                      if (addexercisesservice.imageFile == null ||
                          addexercisesservice.exerciseController.text.isEmpty ||
                          addexercisesservice.descriptionController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Fill all the fields",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        if (isEditMode && selectedDocId != null) {
                          // Update existing exercise
                          await addexercisesservice.updateExercise(
                            selectedDocId ?? "0",
                            addexercisesservice.exerciseController.text,
                            addexercisesservice.descriptionController.text,
                            addexercisesservice.imageFile == Uint8List(0) ? null : addexercisesservice.imageFile,
                          );
                          setState(() {
                            isEditMode = false;
                            selectedDocId = null;
                          });
                        } else {
                          await addexercisesservice.uploadImage(addexercisesservice.imageFile);
                        }

                        setState(() {});
                      }
                    },
                    child: AppText.heading(isEditMode && selectedDocId != null ? "Update" :"Save",
                        fontsize: 18, color: Colors.white),
                  );
                }),
              ],
            ),
            SizedBox(width: 30),
            VerticalDivider(
              color: btncolor,
              width: 8,
            ),
            SizedBox(width: 30),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: addexercisesservice.getAllExercises(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching exercises'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No exercises found'));
                } else {
                  List<Map<String, dynamic>> exercises = snapshot.data!;
                  return Container(
                    width: screenWidth * 0.40,
                    child: ReorderableListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        final docId = exercise['docId'] ?? '';

                        return Container(
                          key: ValueKey(docId),
                         padding: EdgeInsets.all(10),
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          addexercisesservice.exerciseController.text = exercise['exercise'];
                                          addexercisesservice.descriptionController.text = exercise['description'];
                                        });
                                      },
                                      child: Icon(Icons.refresh, color: Colors.blue, size: 20),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isEditMode = true;
                                          selectedDocId = docId;
                                          addexercisesservice.imageFile = Uint8List(0);
                                          addexercisesservice.exerciseController.text = exercise['exercise'];
                                          addexercisesservice.descriptionController.text = exercise['description'];
                                        });
                                      },
                                      child: Icon(Icons.edit, color: Colors.orange, size: 20),
                                    ),
                                    SizedBox(width: 5),
                                    GetBuilder<AddExercisesServices>(
                                      builder: (logic) {
                                        return logic.loading1 == true
                                            ? SpinKitFadingCircle(size: 20, color: Colors.blue)
                                            : GestureDetector(
                                          onTap: () async {
                                            if (docId.isNotEmpty) {
                                              await addexercisesservice.deleteExercise(docId);
                                              setState(() {});
                                            } else {
                                              Get.snackbar(
                                                "Error",
                                                "Document ID is null or empty",
                                                snackPosition: SnackPosition.TOP,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                              );
                                            }
                                          },
                                          child: Icon(Icons.delete, color: Colors.red, size: 20),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    NetworkImageWidget(
                                      imageUrl: exercise['image_url'] ?? '',
                                      imageWidth: 80,
                                      imageHeight: 80,
                                      borderraduis: 10,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText.heading(exercise['exercise'] ?? 'No Exercise Name', fontsize: 16),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: AppText.normal(exercise['description'] ?? 'No Description', fontsize: 16,maxline: 2),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) async {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final movedExercise = exercises.removeAt(oldIndex);
                        exercises.insert(newIndex, movedExercise);

                        for (int i = 0; i < exercises.length; i++) {
                          await addexercisesservice.updateExerciseIndex(exercises[i]['docId'], i);
                        }

                        setState(() {});
                      },
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}