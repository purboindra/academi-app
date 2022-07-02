import 'package:get/get.dart';

import '../controllers/all_schedule_controller.dart';

class AllScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllScheduleController>(
      () => AllScheduleController(),
    );
  }
}
