import 'package:academiapp/app/modules/add_schedule/controllers/add_schedule_controller.dart';
import 'package:academiapp/app/modules/home/controllers/home_controller.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:academiapp/app/utils/notifications_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../controllers/all_schedule_controller.dart';

class AllScheduleView extends GetView<AllScheduleController> {
  RxString dateTime = DateFormat('EEE, MMM d ' 'yyyy')
      .format(Get.find<AllScheduleController>().dateTime.value)
      .obs;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.h20,
                ),
                _dateBar(),
                _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _body() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: Get.find<HomeController>()
          .scheduleStream(Get.find<LoginController>().user.value.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(
              top: Dimensions.h20,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                RxString date = DateFormat('EEE, MMM d ' 'yyyy')
                    .format(controller.dateTime.value)
                    .obs;

                var dateParse = controller.dateTime.value;
                if (data["date"] == date.value) {
                  return Card(
                    child: InkWell(
                      onTap: () async {
                        print(dateParse);
                        print(date);
                        await _bottomSheet(snapshot, index, data);
                      },
                      child: Container(
                        // width: Dimensions.w30 * 12,
                        padding: EdgeInsets.all(
                          Dimensions.h10 + Dimensions.h5,
                        ),
                        margin: EdgeInsets.only(
                          bottom: Dimensions.h20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.w10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${data["course"]}",
                                    style: subHeadingStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.w20,
                                ),
                                Text(
                                  "${data["status"]}",
                                  style: titleStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: data["status"] == "Done"
                                        ? primaryColor
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/schedule.png",
                                  width: Dimensions.w30 * 2,
                                ),
                                SizedBox(
                                  width: Dimensions.w5,
                                ),
                                Expanded(
                                  child: Text(
                                    "${data["startTime"]} - ${data["endTime"]}",
                                    style: titleStyle.copyWith(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.h10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/class.png",
                                  width: Dimensions.w30 * 1.3,
                                ),
                                SizedBox(
                                  width: Dimensions.w10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${data["classCourse"]}",
                                    style: titleStyle.copyWith(),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.w5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          );
        }
        return Center(
          child: Text(
            "You Haven\'t Schedule Yet",
          ),
        );
      },
    );
  }

  _bottomSheet(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      int index, QueryDocumentSnapshot<Map<String, dynamic>> data) async {
    Get.bottomSheet(
      Container(
        color: primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w20,
          vertical: Dimensions.h30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(
                        Dimensions.w20,
                      ),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await Future.delayed(Duration.zero, () => Get.back())
                          .then(
                        (value) => Get.toNamed(
                          Routes.DETAIL_SCHEDULE,
                          arguments: snapshot.data!.docs[index],
                        ),
                      );
                    },
                    child: Text(
                      "Detail Schedule",
                      style: titleStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.h20,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 1),
                      padding: EdgeInsets.all(
                        Dimensions.w20,
                      ),
                      // primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      controller.deleteSchedule(data["id"]);
                      Future.delayed(
                        await Duration(milliseconds: 400),
                        () => Get.back(),
                      );
                    },
                    child: Text(
                      "Delete Schedule",
                      style: titleStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _dateBar() {
    return Container(
        child: DatePicker(
      DateTime.now(),
      daysCount: 7,
      width: Dimensions.w20 * 4,
      height: Dimensions.h30 * 4,
      initialSelectedDate: DateTime.now(),
      selectionColor: primaryColor,
      selectedTextColor: Colors.white,
      dateTextStyle: subHeadingStyle.copyWith(
          // color: Colors.white,
          ),
      dayTextStyle: titleStyle,
      onDateChange: (date) {
        controller.dateTime.value = date;
        controller.dateTime.refresh();
        controller.dateTime.update((val) {
          controller.dateTime.value = date;
        });

        // var dateString = DateFormat('EEE, MMM d ' 'yyyy').format(date);
      },
    ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.chevron_left, color: Colors.black),
      ),
      title: Text('All Schedule'),
      titleTextStyle: titleStyle.copyWith(),
      elevation: 0.5,
      backgroundColor: backgroundColor,
      centerTitle: true,
    );
  }
}
