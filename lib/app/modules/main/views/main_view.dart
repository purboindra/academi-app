import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.find<LoginController>();
    return Scaffold(
      body: Obx(
        () => controller.pages[controller.changeIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.changeIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          selectedIconTheme: IconThemeData(
            size: Dimensions.w30,
          ),
          selectedItemColor: primaryColor,
          unselectedItemColor: darkGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: controller.itemsBar,
        ),
      ),
    );
  }
}
