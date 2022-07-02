import 'dart:convert';

import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/model/user_model.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ScheduleController extends GetxController {
  var scheduleList = [];
  RxList<ScheduleModel> dataSchedule = <ScheduleModel>[].obs;
  final box = GetStorage();

  // getScheduleList(int? index) async {
  //   if (box.read(AppConstant.BOX_ADD_SCHEDULE) != 0) {
  //     // List<dynamic> scheduleList = [];
  //     scheduleList = await box.read(AppConstant.BOX_ADD_SCHEDULE);
  //     scheduleList.forEach((element) {
  //       scheduleList.assignAll(
  //         dataSchedule.map((e) {
  //           print(e.course);
  //           return ScheduleModel.fromJson(e as Map<String, dynamic>);
  //         }).toList(),
  //         // dataSchedule.add(
  //         // ScheduleModel(
  //         //   id: element["id"],
  //         //   course: element["course"],
  //         //   classCourse: element["classCourse"],
  //         //   date: element["date"],
  //         //   startTime: element["startTime"],
  //         //   endTime: element["endTime"],
  //         //   descriptionCourse: element["descriptionCourse"],
  //         //   status: element["status"],
  //         // ),
  //       );
  //     });
  //     print(dataSchedule.length);

  //     dataSchedule.refresh();
  //   }
  //   return dataSchedule;
  // }
}
