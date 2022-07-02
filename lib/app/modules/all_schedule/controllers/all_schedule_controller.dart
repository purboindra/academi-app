import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllScheduleController extends GetxController {
  var dateTime = DateTime.now().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final loginC = Get.find<LoginController>();

  void deleteSchedule(String id) {
    firestore
        .collection(AppConstant.COLLECTION_USER)
        .doc(loginC.user.value.email)
        .collection(AppConstant.COLLECTION_SCHEDULE)
        .doc(id)
        .delete();
  }
}
