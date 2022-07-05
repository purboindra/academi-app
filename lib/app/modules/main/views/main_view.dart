import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/utils/notifications_service.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    NotificationService? notifyHelper = NotificationService();

    final iconList = <IconData>[
      Icons.home,
      Icons.list,
      Icons.note,
      Icons.person,
    ];

    Get.put(LoginController());
    Get.find<LoginController>();
    return Scaffold(
      body: Obx(
        () => controller.pages[controller.changeIndex.value],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
          // box.remove(AppConstant.BOX_ADD_SCHEDULE);
          // Get.toNamed(
          //   Routes.ADD_SCHEDULE,
          //   parameters: {
          //     "page": "fromHomeVie",
          //   },
          // );

          // await notifyHelper.zonedScheduleNotification();

          // await notifyHelper.scheduleDailyTenAMNotification();
          await notifyHelper.showNotification(
            title: "Purbo",
            body: "Hello Purbo Indra",
            payload: "prubo.abs",
          );

          // await notifyHelper.displayNotification(
          //     title: "Halo", body: "Awesome notification");

          // box.remove(AppConstant.BOX_ADD_USER);
        },
        child: Center(
          child: Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar.builder(
          backgroundColor: backgroundColor,
          gapLocation: GapLocation.center,
          onTap: (index) {
            controller.changeIndex.value = index;
          },
          hideAnimationController:
              controller.hideBottomBarAnimationController.value,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? primaryColor : darkGrey;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
              ],
            );
          },
          activeIndex: controller.changeIndex.value,
        ),
      ),
    );
  }
}


// bottomNavigationBar: FloatingActionButton(
          //   onPressed: () {},
          // ),
          // Obx(
          //   () => BottomNavigationBar(
          //     currentIndex: controll)er.changeIndex.value,
          //     onTap: (index) {
          //       controller.changePage(index);
          //     },
          //     selectedIconTheme: IconThemeData(
          //       size: Dimensions.w30,
          //     ),
          //     selectedItemColor: primaryColor,
          //     unselectedItemColor: darkGrey,
          //     showSelectedLabels: false,
          //     showUnselectedLabels: false,
          //     type: BottomNavigationBarType.fixed,
          //     items: controller.itemsBar,
          //   ),
          // ),