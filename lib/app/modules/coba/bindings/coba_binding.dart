import 'package:get/get.dart';

import '../controllers/coba_controller.dart';

class CobaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CobaController>(
      () => CobaController(),
    );
  }
}
