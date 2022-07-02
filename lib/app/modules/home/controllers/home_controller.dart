import 'package:academiapp/app/model/user_model.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  RxInt currentIndex = 0.obs;
  RxBool isSelec = false.obs;

  List<String> names = [
    "Purbo",
    "Indra",
    "Uboy",
  ];

  RxInt check = 10.obs;

  void addCheck(int index) {
    if (checkBox(index).value) {
      index++;
      names.forEach((element) {
        print(element);
      });
    } else {
      print("index $index");
      print("NOT");
    }
  }

  RxBool checkBox(int index) {
    check.value = index;
    print("prev $index");
    if (check.value == index) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CarouselController carouselController = CarouselController();

  void pageChanged(int index) {
    currentIndex.value = index;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> scheduleStream(String email) {
    return firestore
        .collection(AppConstant.COLLECTION_USER)
        .doc(email)
        .collection(AppConstant.COLLECTION_SCHEDULE)
        .snapshots();
  }
}
