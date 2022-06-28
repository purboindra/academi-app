import 'package:academiapp/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var changeIndex = 0.obs;

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
        child: Text("NEXT PAGE"),
      ),
    ),
  ];

  List<BottomNavigationBarItem> itemsBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: "home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: "home",
    ),
  ];
}
