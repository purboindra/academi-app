import 'dart:convert';

import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddScheduleController extends GetxController {
  var selectedDate = DateTime.now().obs;

  // DateTime get selectedDate => _selectedDate.value;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> listOfSchedule = <ScheduleModel>[].obs;

  var selectedStatus = "Undone".obs;
  List<String> statusList = [
    "Undone",
    "Done",
  ].obs;

  var scheduleModel = ScheduleModel().obs;

  var user = UserModel().obs;

  var isLoading = false.obs;

  var startTime = DateFormat("hh:mm:a").format(DateTime.now()).obs;

  var endTime = DateFormat("hh:mm:a").format(DateTime.now()).obs;

  var courseController = TextEditingController();
  var classCourseController = TextEditingController();
  var descriptionController = TextEditingController();

  DateTime? pickerDate;

  Future getDateFromUser(BuildContext context) async {
    pickerDate = await showDatePicker(
      context: (context),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2122),
    );

    var parseSelectedDate =
        DateFormat('EEE, MMM d ' 'yyyy').format(selectedDate.value);
    var pickerParse =
        DateFormat('EEE, MMM d ' 'yyyy').format(pickerDate ?? DateTime.now());
    if (pickerDate != null) {
      pickerParse;
    } else {
      parseSelectedDate;
    }
  }

  chooseTime(BuildContext context, bool isStartedTime) async {
    var timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );

    var timeData = timeOfDay!.format(context).obs;
    if (isStartedTime == true) {
      startTime.value = timeData.value;
    } else {
      endTime.value = timeData.value;
    }
  }

  void addSchedule(String email) async {
    isLoading.value = true;

    if (courseController.text == "" || classCourseController.text == "") {
      Get.snackbar("Oops...", "Please add course or class first");
    } else {
      final index = await firestore
          .collection("users")
          .doc(email)
          .collection("schedule")
          .doc();

      await firestore
          .collection("users")
          .doc(email)
          .collection("schedule")
          .doc(index.id);

      print("index ${index.id}");

      await firestore
          .collection("users")
          .doc(email)
          .collection("schedule")
          .doc(index.id)
          .set({
        "id": index.id,
        "course": courseController.text,
        "classCourse": classCourseController.text,
        "descriptionCourse": descriptionController.text,
        "date": pickerDate != null
            ? DateFormat('EEE, MMM d ' 'yyyy').format(pickerDate!)
            : DateFormat('EEE, MMM d ' 'yyyy').format(selectedDate.value),
        "startTime": startTime.value.toString(),
        "endTime": endTime.value.toString(),
        "status": selectedStatus.value,
      });

      // await firestore.collection("users").doc(email).collection("schedule").add(
      //   {
      //     // "id": id,
      //     "course": courseController.text,
      //     "classCourse": classCourseController.text,
      //     "descriptionCourse": descriptionController.text,
      //     "date": pickerDate != null
      //         ? DateFormat('EEE, MMM d ' 'yyyy').format(pickerDate!)
      //         : DateFormat('EEE, MMM d ' 'yyyy').format(selectedDate.value),
      //     "startTime": startTime.value.toString(),
      //     "endTime": endTime.value.toString(),
      //     "status": selectedStatus.value,
      //   },
      // );

      CollectionReference users = await firestore.collection("users");

      final listSchedule = await users.doc(email).collection("schedule").get();

      if (listSchedule.docs.length != 0) {
        listOfSchedule = <ScheduleModel>[].obs;
        listSchedule.docs.forEach((element) {
          var dataDocumentSchedule = element.data();
          var dataDocumentScheduleId = element.id;

          listOfSchedule.add(
            ScheduleModel(
              id: dataDocumentScheduleId,
              course: dataDocumentSchedule["course"],
              classCourse: dataDocumentSchedule["classCourse"],
              date: dataDocumentSchedule["date"],
              startTime: dataDocumentSchedule["startTime"],
              endTime: dataDocumentSchedule["endTime"],
              status: dataDocumentSchedule["status"],
            ),
          );
        });

        listOfSchedule.refresh();

        update();
        isLoading.value = false;

        if (isLoading.value == false) {
          Get.rawSnackbar(
            message: "Added course",
            backgroundColor: Colors.green.shade500,
          );
        }
      } else {
        user.update((val) {
          val!.scheduleModel;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    courseController.dispose();
    classCourseController.dispose();
    descriptionController.dispose();
  }
}
