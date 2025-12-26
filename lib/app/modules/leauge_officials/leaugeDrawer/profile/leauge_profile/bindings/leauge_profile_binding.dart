import 'package:get/get.dart';

import '../controllers/leauge_profile_controller.dart';

class LeaugeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaugeProfileController>(
      () => LeaugeProfileController(),
    );
  }
}
