import 'dart:convert';

import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/model/user_model.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AddScheduleController extends GetxController {
  var selectedDate = DateTime.now().obs;

  final box = GetStorage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> listOfSchedule = <ScheduleModel>[].obs;

  var selectedStatus = "Undone".obs;

  List<String> statusList = [
    "Undone",
    "Done",
  ].obs;

  var scheduleM = ScheduleModel().obs;

  var user = UserModel().obs;

  var isLoading = false.obs;

  var startTime = DateFormat("hh:mm a").format(DateTime.now()).obs;

  var endTime = DateFormat("hh:mm a").format(DateTime.now()).obs;

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

    String parseSelectedDate =
        DateFormat('EEE, MMM d ' 'yyyy').format(selectedDate.value);
    String pickerParse =
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

    if (timeOfDay != null) {
      var timeData = timeOfDay.format(context).obs;
      if (isStartedTime == true) {
        startTime.value = timeData.value;
      } else {
        endTime.value = timeData.value;
      }
    }
  }

  Future<void> addSchedule(String email) async {
    if (courseController.text == "" || classCourseController.text == "") {
      Get.snackbar("Oops...", "Please add course or class first");
    } else {
      isLoading.value = true;
      final index = await firestore
          .collection(AppConstant.COLLECTION_USER)
          .doc(email)
          .collection(AppConstant.COLLECTION_SCHEDULE)
          .doc();

      await firestore
          .collection(AppConstant.COLLECTION_USER)
          .doc(email)
          .collection(AppConstant.COLLECTION_SCHEDULE)
          .doc(index.id)
          .set({
        // "indexSchedule": indexSchedule,
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

      final scheduleData = firestore
          .collection(AppConstant.COLLECTION_USER)
          .doc(email)
          .collection(AppConstant.COLLECTION_SCHEDULE)
          .doc(index.id);

      print("prev ${listOfSchedule.length}");

      if (scheduleData != 0) {
        listOfSchedule = <ScheduleModel>[].obs;
        final schedule = await firestore
            .collection(AppConstant.COLLECTION_USER)
            .doc(email)
            .collection(AppConstant.COLLECTION_SCHEDULE)
            .get();
        schedule.docs.forEach((element) {
          Map<String, dynamic> dataDocument = element.data();
          String dataDocumentId = element.id;
          listOfSchedule.add(
            ScheduleModel(
              id: dataDocumentId,
              course: dataDocument["course"],
              classCourse: dataDocument["classCourse"],
              date: dataDocument["date"],
              startTime: dataDocument["startTime"],
              endTime: dataDocument["endTime"],
              status: dataDocument["status"],
            ),
          );
        });
        box.write(AppConstant.BOX_ADD_SCHEDULE, listOfSchedule);
      }

      listOfSchedule.refresh();

      print("current ${listOfSchedule.length}");
      update();
      isLoading.value = false;

      if (isLoading.value == false) {
        Get.rawSnackbar(
          message: "Added course",
          backgroundColor: Colors.green.shade500,
        );
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
