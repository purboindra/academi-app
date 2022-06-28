import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailScheduleController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> scheduleStream(String email) {
    return firestore
        .collection('users')
        .doc(email)
        .collection("schedule")
        .snapshots();
  }
}
