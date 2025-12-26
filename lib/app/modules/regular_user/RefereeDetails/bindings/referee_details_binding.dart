import 'package:get/get.dart';

import '../controllers/referee_details_controller.dart';

class RefereeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefereeDetailsController>(
      () => RefereeDetailsController(),
    );
  }
}
