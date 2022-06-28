import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/model/user_model.dart';
import 'package:academiapp/app/modules/add_schedule/controllers/add_schedule_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditScheduleController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var selectedDate = DateTime.now().obs;

  // DateTime get selectedDate => _selectedDate.value;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> listOfSchedule = <ScheduleModel>[].obs;

  var selectedStatus = "Undone".obs;
  List<String> statusList = [
    "Undone",
    "Done",
  ].obs;

  var scheduleModel = ScheduleModel().obs;

  var user = UserModel().obs;

  var isLoading = false.obs;

  var courseController = TextEditingController();
  var classCourseController = TextEditingController();
  var descriptionController = TextEditingController();

  DateTime? pickerDate;

  final addScheduleC = Get.find<AddScheduleController>();

  var startTime = DateFormat("hh:mm:a").format(DateTime.now()).obs;

  var endTime = DateFormat("hh:mm:a").format(DateTime.now()).obs;

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

  void updateSchedule(String email, id) async {
    try {
      CollectionReference users = firestore.collection("users");

      final dataS = users.doc(email).collection("schedule").doc(id).get();

      dataS.then(
        (value) {
          var startTime = value.data()!["startTime"];

          var endTime = value.data()!["endTime"];
          return users.doc(email).collection("schedule").doc(id).update(
            {
              "course": courseController.text != ""
                  ? courseController.text
                  : value.data()!["course"],
              "classCourse": classCourseController.text != ""
                  ? classCourseController.text
                  : value.data()!["classCourse"],
              "descriptionCourse": descriptionController.text != ""
                  ? descriptionController.text
                  : value.data()!["descriptionCourse"],
              "date": pickerDate != null
                  ? DateFormat('EEE, MMM d ' 'yyyy').format(pickerDate!)
                  : value.data()!["date"],
              "startTime": startTime.toString() != ""
                  ? startTime.toString()
                  : value.data()!["startTime"],
              "endTime": endTime.toString() != ''
                  ? endTime.toString()
                  : value.data()!["endTime"],
              "status": selectedStatus.value != ""
                  ? selectedStatus.value
                  : value.data()!["status"],
            },
          );
        },
      );

      await Future.delayed(Duration.zero).then((value) async {
        return Get.rawSnackbar(
          message: "Course Editted",
          backgroundColor: Colors.green.shade500,
        );
      }).then((value) {
        return Future.delayed(Duration(seconds: 2),
            () => Get.offNamedUntil(Routes.MAIN, (route) => false));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> editScheduleStream(
      String email, id) {
    try {
      final index =
          firestore.collection("users").doc(email).collection("schedule").doc();

      return firestore
          .collection('users')
          .doc(email)
          .collection("schedule")
          .doc(index.id)
          .snapshots();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
