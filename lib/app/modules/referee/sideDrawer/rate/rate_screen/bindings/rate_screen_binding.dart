import 'package:get/get.dart';

import '../controllers/rate_screen_controller.dart';

class RateScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateScreenController>(
      () => RateScreenController(),
    );
  }
}
