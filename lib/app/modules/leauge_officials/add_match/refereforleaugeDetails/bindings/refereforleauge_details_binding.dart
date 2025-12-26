import 'package:get/get.dart';

import '../controllers/refereforleauge_details_controller.dart';

class RefereforleaugeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereforleaugeDetailsController>(
      () => RefereforleaugeDetailsController(),
    );
  }
}
