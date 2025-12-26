import 'package:get/get.dart';

import '../controllers/rate_referee_controller.dart';

class RateRefereeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateRefereeController>(
      () => RateRefereeController(),
    );
  }
}
