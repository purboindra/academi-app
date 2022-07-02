import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_schedule_controller.dart';

class DetailScheduleView extends GetView<DetailScheduleController> {
  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: Text('Details Schedule'),
        titleTextStyle: titleStyle.copyWith(),
        elevation: 0.5,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Here\'s Schedule For You",
              style: subHeadingStyle.copyWith(),
            ),
            SizedBox(
              height: Dimensions.h30,
            ),
            Text(
              "Course",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Text(
              "${arguments["course"]}",
              style: titleStyle.copyWith(
                color: darkGrey,
              ),
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Description",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Text(
              "${arguments["descriptionCourse"] != "" ? arguments["descriptionCourse"] : "-"}",
              style: titleStyle.copyWith(
                color: darkGrey,
              ),
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Class Course",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Text(
              "${arguments["classCourse"] != "" ? arguments["classCourse"] : "Please Contact Some Lecturer"}",
              style: titleStyle.copyWith(
                color: darkGrey,
              ),
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Date",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: Dimensions.w30 + Dimensions.w5,
                  color: darkGrey,
                ),
                SizedBox(
                  width: Dimensions.w10,
                ),
                Text(
                  "${arguments["date"] != "null" ? arguments["date"] : "The Date Would Be Announced"}",
                  style: titleStyle.copyWith(
                    color: darkGrey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Time",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Row(
              children: [
                Icon(
                  Icons.lock_clock_outlined,
                  size: Dimensions.w30 + Dimensions.w5,
                  color: darkGrey,
                ),
                SizedBox(
                  width: Dimensions.w10,
                ),
                Text(
                  "${arguments["startTime"]} - ${arguments["endTime"]}",
                  style: titleStyle.copyWith(
                    color: darkGrey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Text(
              "Status",
              style: titleStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),
            Text(
              "${arguments["status"]}",
              style: titleStyle.copyWith(
                color: arguments["status"] == "Done"
                    ? purpleColor
                    : Colors.red.shade300,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w20,
        ),
        margin: EdgeInsets.only(
          bottom: Dimensions.h30 + Dimensions.h20,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            padding: EdgeInsets.all(
              Dimensions.w20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.w10),
            ),
          ),
          onPressed: () {
            Get.toNamed(Routes.EDIT_SCHEDULE,
                arguments: arguments,
                parameters: {
                  "page": "detailToEditPage",
                }
                // parameters: {
                //   "detailS": arguments,
                // },
                );
          },
          child: Text(
            "Edit Schedule",
            style: titleStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
