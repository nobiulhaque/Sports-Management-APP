import 'package:get/get.dart';

import '../controllers/refereforleauge_controller.dart';

class RefereforleaugeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereforleaugeController>(
      () => RefereforleaugeController(),
    );
  }
}
