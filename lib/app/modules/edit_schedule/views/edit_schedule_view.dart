import 'package:academiapp/app/modules/add_schedule/controllers/add_schedule_controller.dart';
import 'package:academiapp/app/modules/home/controllers/home_controller.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/widgets/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/edit_schedule_controller.dart';

class EditScheduleView extends GetView<EditScheduleController> {
  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    var params = Get.parameters;

    // print(params["course"]);
    final loginC = Get.find<LoginController>();
    var emailUser = loginC.user.value.email!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: Text('Edit Schedule'),
        titleTextStyle: titleStyle.copyWith(),
        elevation: 0.5,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            // stream: controller.editScheduleStream(emailUser, params["id"]),
            stream: Get.find<HomeController>().scheduleStream(emailUser),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Oops.. Something Wrong"),
                );
              }
              if (snapshot.hasData) {
                // var snp = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MyInputField(
                        controller:
                            // Get.find<AddScheduleController>().courseController,
                            controller.courseController,
                        title: "Course",
                        hint: "${arguments["course"]}",
                        widget: Icon(
                          Icons.menu,
                        ),
                      ),
                      MyInputField(
                        controller: controller.classCourseController,
                        // controller: Get.find<AddScheduleController>()
                        //     .classCourseController,
                        title: "Class",
                        hint: "${arguments["classCourse"]}",
                        widget: Icon(
                          Icons.menu,
                        ),
                      ),
                      MyInputField(
                        controller: controller.descriptionController,
                        title: "Description",
                        hint: "${arguments["descriptionCourse"]}",
                        widget: Icon(
                          Icons.description,
                        ),
                      ),
                      Obx(() => MyInputField(
                            title: "Date",
                            hint: DateFormat.yMd()
                                .format(controller.selectedDate.value)
                                .toString(),
                            widget: IconButton(
                              onPressed: () {
                                controller.getDateFromUser(context);
                              },
                              icon: Icon(
                                Icons.house_outlined,
                              ),
                            ),
                          )),
                      Obx(() => Row(
                            children: [
                              Expanded(
                                child: MyInputField(
                                  title: "Start",
                                  hint:
                                      "${controller.startTime.value.toString()}",
                                  widget: IconButton(
                                    onPressed: () {
                                      controller.chooseTime(context, true);
                                    },
                                    icon: Icon(
                                      Icons.hourglass_top,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.w20,
                              ),
                              Expanded(
                                child: MyInputField(
                                  title: "End",
                                  hint: controller.endTime.value == ""
                                      ? "${controller.endTime.value.toString()}"
                                      : arguments["endTime"],
                                  widget: IconButton(
                                    onPressed: () {
                                      controller.chooseTime(context, false);
                                    },
                                    icon: Icon(
                                      Icons.hourglass_bottom,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Obx(
                        () => MyInputField(
                          title: "Status",
                          hint: '${controller.selectedStatus.value}',
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            style: subTitleStyle,
                            underline: Container(
                              height: 0,
                            ),
                            items: controller.statusList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(value.toString()));
                            }).toList(),
                            onChanged: (String? newVal) {
                              controller.selectedStatus.value = newVal!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h30 * 1.8,
                      ),
                      Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.w10),
                              ),
                              primary: primaryColor,
                              padding: EdgeInsets.all(
                                Dimensions.w20,
                              ),
                              minimumSize: Size(
                                Dimensions.w,
                                Dimensions.h30,
                              ),
                            ),
                            onPressed: () {
                              controller.updateSchedule(
                                  emailUser, arguments["id"]);
                            },
                            child: Text(
                              loginC.isLoading.isFalse
                                  ? "Edit Schedule"
                                  : "Loading",
                              style: titleStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Something went wrong"),
                );
              }
            }),
      ),
    );
  }
}
