import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CarouselController carouselController = CarouselController();

  void pageChanged(int index) {
    currentIndex.value = index;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> scheduleStream(String email) {
    return firestore
        .collection('users')
        .doc(email)
        .collection("schedule")
        .snapshots();
  }
}
