import 'package:academiapp/app/modules/home/views/home_view.dart';
import 'package:academiapp/app/utils/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  late Rx<AnimationController> hideBottomBarAnimationController =
      AnimationController(vsync: this).obs;

  var changeIndex = 0.obs;

  var notifyHelper;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    notifyHelper = NotificationService();
    notifyHelper.initializeNotification();
  }

  void changePage(int index) {
    changeIndex.value = index;
  }

  List pages = [
    HomeView(),
    Container(
      child: Center(
        child: Text("NEXT PAGE"),
      ),
    ),
    Container(
      child: Center(
        child: Text("NEXT NEXT PAGE"),
      ),
    ),
    Container(
      child: Center(
        child: Text("NEXT NEXT PAGE"),
      ),
    ),
  ];

  // List<BottomNavigationBarItem> itemsBar = [
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.home),
  //     label: "home",
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.menu),
  //     label: "home",
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Icons.person,
  //     ),
  //     label: "home",
  //   ),
  // ];
}
