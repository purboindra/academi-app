import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/widgets/input_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  @override
  Widget build(BuildContext context) {
    var params = Get.parameters;
    final loginC = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (params["page"] == "fromHomeVie") {
              Get.offAllNamed(Routes.MAIN);
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: Text('Add Schedule'),
        titleTextStyle: titleStyle.copyWith(),
        elevation: 0.5,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                MyInputField(
                  controller: controller.courseController,
                  title: "Course",
                  hint: "Add course",
                ),
                MyInputField(
                  controller: controller.classCourseController,
                  title: "Class",
                  hint: "Add class",
                ),
                MyInputField(
                  controller: controller.descriptionController,
                  title: "Description",
                  hint: "Add description",
                ),
                Obx(() => MyInputField(
                      onTap: () {
                        controller.getDateFromUser(context);
                      },
                      title: "Date",
                      hint: DateFormat.yMd()
                          .format(controller.selectedDate.value),
                      widget: IconButton(
                        onPressed: () {
                          controller.getDateFromUser(context);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    )),
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: MyInputField(
                            onTap: () {
                              controller.chooseTime(context, true);
                            },
                            title: "Start",
                            hint: "${controller.startTime.value.toString()}",
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
                            onTap: () {
                              controller.chooseTime(context, false);
                            },
                            title: "End",
                            hint: "${controller.endTime.value.toString()}",
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
                            value: value.toString(), child: Text(value));
                      }).toList(),
                      onChanged: (String? newVal) {
                        controller.selectedStatus.value = newVal!;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.h30 * 1.5,
                ),
                Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.w10),
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
                        if (controller.startTime.value ==
                            controller.endTime.value) {
                          Get.snackbar(
                              "Oops...", "You haven\'t adding time yet");
                        } else {
                          controller
                              .addSchedule(loginC.userCredential!.user!.email!);
                        }
                      },
                      child: Text(
                        loginC.isLoading.isFalse ? "Add Schedule" : "Loading",
                        style: titleStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
