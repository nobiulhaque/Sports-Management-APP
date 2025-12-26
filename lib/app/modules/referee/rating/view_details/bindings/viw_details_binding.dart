import 'package:get/get.dart';

import '../controllers/viw_details_controller.dart';

class ViwDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViwDetailsController>(
      () => ViwDetailsController(),
    );
  }
}
