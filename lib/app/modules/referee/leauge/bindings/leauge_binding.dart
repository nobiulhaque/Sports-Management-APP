import 'package:get/get.dart';

import '../controllers/leauge_controller.dart';

class LeaugeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaugeController>(
      () => LeaugeController(),
    );
  }
}
