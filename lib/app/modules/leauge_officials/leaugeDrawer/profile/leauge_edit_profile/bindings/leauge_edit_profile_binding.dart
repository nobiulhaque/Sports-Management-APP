import 'package:get/get.dart';

import '../controllers/leauge_edit_profile_controller.dart';

class LeaugeEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaugeEditProfileController>(
      () => LeaugeEditProfileController(),
    );
  }
}
