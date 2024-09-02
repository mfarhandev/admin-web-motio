import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:motion_web/services/addexercisesservices.dart';
import 'package:motion_web/services/addmotionservice.dart';
import 'package:motion_web/services/addsubexercisesservies.dart';
import 'package:motion_web/utils/customcolor.dart';
import 'package:motion_web/widgets/ElevatedButtonWidget.dart';
import 'package:motion_web/widgets/text_widget.dart';

class AddMotionsScreen extends StatefulWidget {
  const AddMotionsScreen({super.key});

  @override
  State<AddMotionsScreen> createState() => _AddMotionsScreenState();
}

class _AddMotionsScreenState extends State<AddMotionsScreen> {
  final AddExercisesServices addExercisesServices = Get.put(AddExercisesServices());
  final AddSubExercisesServies addSubExercisesServies = Get.put(AddSubExercisesServies());
  final AddMotionService addMotionService = Get.put(AddMotionService());

  List<Map<String, dynamic>> exercises = [];
  List<Map<String, dynamic>> reasons = [];
  String? selectedExercise;
  String? selectedReason;
  String? selectedDocId;



  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    exercises = await addExercisesServices.getAllExercises();
    setState(() {});
  }

  Future<void> fetchReasons(String id) async {
    reasons = await addSubExercisesServies.getReasonsForExercise(id);
    setState(() {});
  }

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mov'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        addMotionService.videoFile = file.bytes!;
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
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: screenWidth * 0.30,
                    child: DropdownButtonFormField<String>(
                      value: selectedExercise,
                      hint: Text('Select Exercise'),
                      items: exercises.map((exercise) {
                        return DropdownMenuItem<String>(
                          value: exercise['docId'],
                          child: Text(exercise['exercise'] ?? 'No Exercise Name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedExercise = value;
                          selectedReason = null; // Reset selected reason
                          fetchReasons(value!);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                    child: DropdownButtonFormField<String>(
                      value: selectedReason,
                      hint: Text('Select Reason'),
                      items: reasons.map((reason) {
                        return DropdownMenuItem<String>(
                          value: reason['id'],
                          child: Text(reason['reason'] ?? 'No Reason Name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                  GestureDetector(
                      onTap: addMotionService.check == true && addMotionService.check1 == false  ? () {} : pickVideo,
                      child: addMotionService.check == false && addMotionService.videoFile == null
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
                              Icon(Icons.upload_file_outlined,
                                  color: Colors.grey, size: 30),
                              AppText.normal("Upload the Onboarding Video",
                                  color: Colors.grey),
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
                              Icon(Icons.upload_file_outlined,
                                  color: Colors.blue, size: 30),
                              AppText.normal("Video Selected",
                                  color: Colors.blue),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 10),

                  Container(
                    width: screenWidth * 0.30,
                    child: TextField(
                    //  enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 1,
                      cursorColor: Colors.blue,
                      controller: addMotionService.titileController,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          hintText: 'Title',
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
                  SizedBox(height: 20),

                  Container(
                    width: screenWidth * 0.30,
                    child: TextField(
                      //  enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 1,
                      cursorColor: Colors.blue,
                      controller: addMotionService.header1Controller,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          hintText: 'Equipment Needed',
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
                     // enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 3,
                      cursorColor: Colors.blue,
                      controller: addMotionService.equipementController,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
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
                  SizedBox(height: 20),

                  Container(
                    width: screenWidth * 0.30,
                    child: TextField(
                      //  enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 1,
                      cursorColor: Colors.blue,
                      controller: addMotionService.header2Controller,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          hintText: 'Starting Position',
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
                      // enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 3,
                      cursorColor: Colors.blue,
                        controller: addMotionService.StartingpositionController,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
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
                  SizedBox(height: 20),

                  Container(
                    width: screenWidth * 0.30,
                    child: TextField(
                      //  enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 1,
                      cursorColor: Colors.blue,
                      controller: addMotionService.header3Controller,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          hintText: 'Exercise Description',
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
                      // enabled: onboardingfirebase.check == true ? false : true,
                      maxLines: 3,
                      cursorColor: Colors.blue,
                     controller: addMotionService.ExerciseDescriptionController,
                      style: TextStyle(fontFamily: "PTSerif", color: Colors.black),
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

                  SizedBox(height: 20),
                  GetBuilder<AddMotionService>(builder: (logic) {
                    return logic.loading == true
                        ? Center(child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    )
                    )
                        : ElevatedButtonWidget(
                      buttonHeight: 60,
                      buttonborderRadius: 15,
                      buttonBackgroundColor: btncolor,
                      buttonWidth: screenWidth * 0.30,
                      onPressed: () async{
                        if (selectedExercise == null ||
                            selectedReason == null ||
                            addMotionService.videoFile == null ||
                            addMotionService.titileController.text.isEmpty ||
                            addMotionService.equipementController.text.isEmpty ||
                            addMotionService.StartingpositionController.text.isEmpty ||
                            addMotionService.ExerciseDescriptionController.text.isEmpty
                        )
                        {
                          Get.snackbar(
                            "Error",
                            "Fill all the fields",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                        else {

                          if(selectedDocId != null){

                            await addMotionService.updateMotion(
                                selectedExercise!,
                                selectedReason!,
                                selectedDocId!,
                                addMotionService.videoFile == Uint8List(0) ? null : addMotionService.videoFile,
                            );
                            setState(() {

                            });

                          }else {
                            await addMotionService.uploadVideo(
                                addMotionService.videoFile,
                                selectedExercise!,
                                selectedReason!,

                            );
                            setState(() {

                            });
                          }

                        }
                      },
                      child: AppText.heading(selectedDocId != null ? "Update" :  "Save",
                          fontsize: 18, color: Colors.white),
                    );
                  })
                ],
              ),
            ),
            SizedBox(width: 30),
            VerticalDivider(color: btncolor, width: 8),
            SizedBox(width: 30),
            // show it here on the base of select exercises and selected reason
            if (selectedExercise != null && selectedReason != null)
              FutureBuilder<List<Map<String, dynamic>>>(
                future: addMotionService.getMotionsForReason(selectedExercise!, selectedReason!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching motions'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No motions found'));
                  } else {
                    List<Map<String, dynamic>> motions = snapshot.data!;
                    return Container(
                      width: screenWidth * 0.40,
                      child: ReorderableListView.builder(
                        itemCount: motions.length,
                        itemBuilder: (context, index) {
                          final motion = motions[index];
                          return Container(
                            key: ValueKey(motion['id']),
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: btncolor, width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          addMotionService.titileController.text = motion['title'];
                                          addMotionService.header1Controller.text = motion['header1'];
                                          addMotionService.equipementController.text = motion['equipmentsNeeded'];
                                          addMotionService.header2Controller.text = motion['header2'];
                                          addMotionService.StartingpositionController.text = motion['starting_position'];
                                          addMotionService.header3Controller.text = motion['header3'];
                                          addMotionService.ExerciseDescriptionController.text = motion['exercise_description'];

                                        });
                                      },
                                      child: Icon(Icons.refresh, color: Colors.blue, size: 20),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          addMotionService.check1 = true;
                                          selectedDocId = motion['id'];
                                          addMotionService.titileController.text = motion['title'];
                                          addMotionService.header1Controller.text = motion['header1'];
                                          addMotionService.equipementController.text = motion['equipmentsNeeded'];
                                          addMotionService.header2Controller.text = motion['header2'];
                                          addMotionService.StartingpositionController.text = motion['starting_position'];
                                          addMotionService.header3Controller.text = motion['header3'];
                                          addMotionService.ExerciseDescriptionController.text = motion['exercise_description'];
                                          addMotionService.videoFile =  Uint8List(0);

                                        });


                                      },
                                      child: Icon(Icons.edit, color: Colors.orange, size: 20),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () async {
                                        await addMotionService.deleteMotion(
                                          selectedExercise!,
                                          selectedReason!,
                                          motion['id'],
                                        );
                                        setState(() {});
                                      },
                                      child: Icon(Icons.delete, color: Colors.red, size: 20),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText.heading(motion['title'] ?? 'No Title', fontsize: 18),
                                  ],
                                ),
                               Padding(
                                 padding: const EdgeInsets.only(right: 30),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     SizedBox(height: 10),
                                     AppText.normal(motion['equipmentsNeeded'] ?? 'No Equipments Needed',maxline: 2),
                                     SizedBox(height: 10),
                                     AppText.normal(motion['starting_position'] ?? 'No Starting Position',maxline: 2),
                                     SizedBox(height: 10),
                                     AppText.normal(motion['exercise_description'] ?? 'No Exercise Description',maxline: 2),
                                   ],
                                 ),
                               )
                              ],
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) async {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final movedMotion = motions.removeAt(oldIndex);
                          motions.insert(newIndex, movedMotion);

                          for (int i = 0; i < motions.length; i++) {
                            await addMotionService.updateMotionIndex(selectedExercise!, selectedReason!, motions[i]['id'], i);
                          }

                          setState(() {});
                        },
                      ),
                    );
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}